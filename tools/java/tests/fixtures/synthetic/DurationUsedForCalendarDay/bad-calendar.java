import java.time.*; class Probe { ZonedDateTime next(ZonedDateTime now) { return now.plus(Duration.ofDays(1)); } }
