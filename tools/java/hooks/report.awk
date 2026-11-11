# 僅解析固定版本工具產生的 XML；不是通用 XML parser。
# 用標籤分隔，支援多行屬性、XML entity、空格與冒號檔名。
BEGIN {
    RS="\n"; snapshot=ENVIRON["DEV_RULE_SNAPSHOT"]
    while ((getline row < ENVIRON["DEV_RULE_RANGES"]) > 0) {
        split(row,a,"\t"); n[a[1]]++; lo[a[1],n[a[1]]]=a[2]; hi[a[1],n[a[1]]]=a[3]
    }
    close(ENVIRON["DEV_RULE_RANGES"])
    RS="<"
}
function decode(s) {
    gsub(/&quot;/,"\"",s); gsub(/&apos;/,"\047",s)
    gsub(/&lt;/,"<",s); gsub(/&gt;/,">",s)
    gsub(/&#10;|&#xA;/," ",s); gsub(/&#13;|&#xD;/," ",s)
    gsub(/&#9;|&#x9;/," ",s); gsub(/&amp;/,"\\&",s)
    return s
}
function attr(s,key, t) {
    if (!match(s,"[[:space:]]" key "=\"[^\"]*\"")) return ""
    t=substr(s,RSTART,RLENGTH); sub(/^[^=]*="/,"",t); sub(/"$/,"",t); return decode(t)
}
function failure(text) { print "dev-rule: " text > "/dev/stderr"; broken=1 }
function emit(line,severity,message, i,changed) {
    line += 0
    if (substr(file,1,length(snapshot))!=snapshot) { failure("報告檔案不屬於 staged 快照：" file); return }
    path=substr(file,length(snapshot)+1)
    # 未帶條文 ID 的診斷（包括語法錯誤）一律視為工具／設定錯誤。
    if (message !~ /\[JV-[A-Z][A-Z]-[0-9][0-9][0-9]\]/) { failure(path ":" line " " message); return }
    changed=(ENVIRON["DEV_RULE_FULL_FILE"]=="1")
    for(i=1;i<=n[path];i++) if(line>=lo[path,i] && line<=hi[path,i]) changed=1
    if (!changed) return
    gsub(/[\r\n\t]+/," ",message); sub(/^[[:space:]]+/,"",message); sub(/[[:space:]]+$/,"",message)
    print path ":" line " " message (severity=="warning"?" (warn)":"")
    if(severity!="warning" && severity!="info" && severity!="ignore") blocked=1
}
/^file[[:space:]]/ { file=attr($0,"name") }
/^error[[:space:]]/ { emit(attr($0,"line"),attr($0,"severity"),attr($0,"message")) }
/^violation[[:space:]]/ {
    line=attr($0,"beginline"); priority=attr($0,"priority")
    message=$0; sub(/^[^>]*>/,"",message); emit(line,priority>=3?"warning":"error",decode(message))
}
/^error[>]|^configerror[[:space:]]|^error[[:space:]][^>]*filename=/ { failure("PMD 分析或設定錯誤：" $0) }
END { if(broken) exit 2; if(blocked) exit 1 }
