# frozen_string_literal: true
require 'json'
require 'open3'
require 'pathname'
module BodyRestructuring
  BASELINE = '350668eb14ede247af22c782323beebf940c2a5f'.freeze
  KINDS = %w[整條保留 保留增量 拆分 整條移除 轉為驗收入口 整份併入他檔].freeze
  def self.original(path, ref = BASELINE)
    args=['git'];args << "--git-dir=#{ENV['BODY_GIT_DIR']}" if ENV['BODY_GIT_DIR']
    out,err,status=Open3.capture3(*args,'show',"#{ref}:#{path}")
    raise "無法讀取基準 #{path}: #{err.strip}" unless status.success?
    out
  end
  def self.body(text); text.split("## 驗收要求",2).first; end
  # 保留句號及原有空白，串回後須與來源行逐字相同；條號／粗體標題另由全文差異保護。
  def self.sentences(text)
    body(text).lines.reject{|l|l.strip.empty? || l.start_with?('#','<a ')}.flat_map do |line|
      line.sub(/^\d+\. \*\*[^*]+\*\*。/,'').strip.scan(/[^。]+。|[^。]+\z/)
    end
  end
  def self.rules(text)
    body(text).lines.map{|l|m=l.match(/^(\d+)\. \*\*([^*]+)\*\*。(.*)$/);m && [m[1].to_i,m[2],m[3]]}.compact
  end
  def self.edits(before,after)
    a=before.lines;b=after.lines;n=a.size;m=b.size;d=Array.new(n+1){Array.new(m+1,0)}
    (n-1).downto(0){|i|(m-1).downto(0){|j|d[i][j]=a[i]==b[j] ? d[i+1][j+1]+1 : [d[i+1][j],d[i][j+1]].max}}
    i=0;j=0;result=[]
    while i<n || j<m
      if i<n && j<m && a[i]==b[j];i+=1;j+=1;next;end
      edit={'baseline_line'=>i+1,'remove'=>[],'insert'=>[]}
      until (i==n && j==m) || (i<n && j<m && a[i]==b[j])
        if j<m && (i==n || d[i][j+1]>d[i+1][j]);edit['insert']<<b[j];j+=1
        else;edit['remove']<<a[i];i+=1;end
      end
      result<<edit
    end
    result
  end
  def self.apply(source,edits)
    lines=source.lines;out=[];cursor=0
    edits.each do |e|
      pos=e.fetch('baseline_line')-1;remove=e.fetch('remove')
      raise '差異區塊重疊或來源不符' unless pos>=cursor && pos<=lines.size && lines[pos,remove.size]==remove
      raise '差異理由不足' unless e.fetch('reason','').gsub(/\s/,'').size>=20
      out.concat(lines[cursor...pos]);out.concat(e.fetch('insert'));cursor=pos+remove.size
    end
    (out+lines[cursor..]).join
  end
end
