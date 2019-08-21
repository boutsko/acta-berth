#!/usr/bin/env ruby

class Parser

out_file = File.open('.quest.ymla', 'w')
out_file_tmp = File.open('.quest.tmp', 'w')

IO.foreach('quest.txt') do |line|
  line.gsub!(/\s\s*/, " ")
  if line =~ /^\-?(\d\.?\d\d?)/  # remove d- dash, look, try /^-?(...)/
    line.gsub!(/\n$/, "") # remove /n from end of ^\d\d lines
    line.gsub!(/^/,"\n") # add /n to \d\d starting lines
  else
    line.gsub!(/\n$/, " ") # assemble !^\d\d to one ^\d\d
  end

  out_file_tmp.print line
end

out_file_tmp.rewind

# enter default data :
out_file.puts "digest                                   :"
out_file.puts "name_ru                                  :"
out_file.puts "flag_ru                                  :"
out_file.puts "last_port                                :"
out_file.puts "last_departure_date                      :"
out_file.puts "arrival_ts                               :"
out_file.puts "departure_ts                             :"
out_file.puts "bl_figure                                :"
out_file.puts "#----------------------------------------------------------------------"
out_file.puts "_rgt                                     :"
out_file.puts "_reduced_gt                              :"
out_file.puts "#----------------------------------------------------------------------"

IO.foreach('.quest.tmp') do |line|
  line.gsub!(/\s\s*/, " ")

  out_file.print "_name                                    : #{$1}\n" if line =~ /^[-\s]*01.*?:[ \s]*([-\w\/ ]+)/i
  out_file.print "_flag                                    : #{$1}\n" if line =~ /^[-\s]*04.*?:[ \s]*([\w ]+)/i
  out_file.print "_arrival_time_v                          : #{$1}\n" if line =~ /^[-\s]*32.*?:  *([\w\d: \/]+)$/i;
  out_file.print "_owner                                   : #{$1}\n" if line =~ /^[-\s]*07.*?:[ \s]*([\w\d. ]+)/i
  out_file.print "_port_reg                                : #{$1}\n" if line =~ /^[-\s]*09.*?:[ \s]*([\w\d. ]+)/i
  out_file.print "_imo                                     : #{$1}\n" if line =~ /^[-\s]*05.*?:[ \s]*([\d]+)/i;
  out_file.print "_call_sign                               : #{$1}\n" if line =~ /^[-\s]*06.*?:[ \s]*([\d\w]+)/i;
  out_file.print "_dwt                                     : #{$1}\n" if line =~ /^[-\s]*12.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_gt                                      : #{$1}\n" if line =~ /^[-\s]*13.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_nrt                                     : #{$1}\n" if line =~ /^[-\s]*14.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_loa                                     : #{$1}\n" if line =~ /^[-\s]*16.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_beam                                    : #{$1}\n" if line =~ /^[-\s]*17.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_mdepth                                  : #{$1}\n" if line =~ /^[-\s]*18.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_sdraft                                  : #{$1}\n" if line =~ /^[-\s]*20.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_displacement                            : #{$1}\n" if line =~ /^[-\s]*23.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_me_power                                : #{$1}\n" if line =~ /^[-\s]*25.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_draft_arrival_fore                      : #{$1}\n" if line =~ /^[-\s]*34.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_draft_arrival_aft                       : #{$1}\n" if line =~ /^[-\s]*35.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_ballast                                 : #{$1}\n" if line =~ /^[-\s]*36.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_ballast_both_sides                      : #{$1}\n" if line =~ /^[-\s]*37.*?:[ \s]*([\w() ]+)/i;
  out_file.print "_last_cargo                              : #{$1}\n" if line =~ /^[-\s]*47.*?:[ \s]*(.*)$/i;
  out_file.print "_crew_number                             : #{$1}\n" if line =~ /^[-\s]*40.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_crew_nationals                          : #{$1}\n" if line =~ /^[-\s]*41.*?:[ \s]*(.*)$/i
  out_file.print "_passenger_number                        : #{$1}\n" if line =~ /^[-\s]*42.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_cargo_quantity_v                        : #{$1}\n" if line =~ /^[-\s]*52.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_draft_departure                         : #{$1}\n" if line =~ /^[-\s]*54.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_clc_terms                               : #{$1.gsub(/:/, " ")}\n" if line =~ /^[-\s]*65.*?:[ \s]*([\d\w\W\.,: ]+)/i;

  out_file.print "_bunkers_departure_last                  : #{$1.gsub(/:/, " ")}
# _fo_departure_last                       :
# _go_departure_last                       :\n" if line =~ /^[-\s]*46\.1.*?:[ \s]*([\d\w\W\.,: ]+)/i;

  out_file.print "_bunkers_on_arrival                      : #{$1.gsub(/:/, " ")}\n" if line =~ /^[-\s]*46\.2.*?:[ \s]*([\d\w\W\.,: ]+)/i;
  out_file.print "_bunkers_on_departure                      : #{$1.gsub(/:/, " ")}\n" if line =~ /^[-\s]*46\.3?:[ \s]*([\d\w\W\.,: ]+)/i;

  #---------------------------------------------------------------------#
  # adding ipp values                                                   #
  #---------------------------------------------------------------------#

  out_file.print "_freeboard_loaded                        : #{$1}\n" if line =~ /^[-\s]*56.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_derrick_quantity                        : #{$1}\n" if line =~ /^[-\s]*2\.7.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_derrick_lift_power                      : #{$1}\n" if line =~ /^[-\s]*2\.9.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_derrick_overhang                        : #{$1}\n" if line =~ /^[-\s]*2\.10.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_distance_manifold_waterlevel_arrival    : #{$1}\n" if line =~ /^[-\s]*2\.11.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_distance_manifold_waterlevel_departure  : #{$1}\n" if line =~ /^[-\s]*2\.12.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_manifold_number_v                       : #{$1}\n" if line =~ /^[-\s]*2\.2.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_manifold_diameter                       : #{$1}\n" if line =~ /^[-\s]*2\.3.*?:[ \s]*(.*)/i;
  out_file.print "_manifold_flange_thikness                : #{$1}\n" if line =~ /^[-\s]*2\.4.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_manifold_material                       : #{$1}\n" if line =~ /^[-\s]*2\.5.*?:[ \s]*(.*)/i;
  out_file.print "_distance_rail_manifold                  : #{$1}\n" if line =~ /^[-\s]*2\.13.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_distance_between_manifold               : #{$1}\n" if line =~ /^[-\s]*2\.15.*?:[ \s]*([\d\., ]+)/i;
  out_file.print "_distance_deck_manifold                  : #{$1}\n" if line =~ /^[-\s]*2\.14.*?:[ \s]*([\d\., ]+)/i;

#isps
  out_file.print "_issc_number                             : #{$1}\n" if line =~ /^[-\s]*3\.1.*?:[ \s]*(.*)$/i;
  out_file.print "_issc_class                              : #{$1}\n" if line =~ /^[-\s]*3\.3.*?:[ \s]*(.*)$/i;
  out_file.print "_issc_terms                              : #{$1.gsub(/:/, " ")}
_issc_issued                             :
_issc_valid                              :\n" if line =~ /^[-\s]*3\.2.*?:[ \s]*([\d\w\W\.,: ]+)/i;
end

out_file.close
