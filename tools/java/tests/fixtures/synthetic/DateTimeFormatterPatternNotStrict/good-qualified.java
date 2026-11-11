import java.time.format.*; import java.util.Locale; class Probe { DateTimeFormatter formatter=DateTimeFormatter.ofPattern("uuuu-MM-dd",Locale.ROOT).withResolverStyle(ResolverStyle.STRICT); }
