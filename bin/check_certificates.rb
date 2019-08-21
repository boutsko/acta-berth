# coding: utf-8
#!/Users/sampai/.rbenv/versions/2.2.1/bin/ruby
# -*- coding: utf-8 -*-
require 'watir-webdriver'
require 'ostruct'

certificates = {
  "01" => "register",
  "02" => "crew-list",
  "04" => "tonnage",
  "05" => "class",
  "06" => "load-line",
  "07" => "maritime-declaration-of-health",
  "08" => "ship-sanitation-control-exemption",
  "10" => "clc-oil",
  "11" => "clc-bunker",
  "12" => "iopp",
  "13" => "garbage-polution-prevention",
  "14" => "sewage-polution-prevention",
  "15" => "air-polution-prevention",
  "16" => "issc",
  "19" => "safety-construction",
  "20" => "safety-equipment",
  "21" => "safety-radio",
  "23" => "maritime-labour",
  "24" => "declaraion-maritime-labour",
  "25" => "safety-management",
  "31" => "document-of-compliance",
  "34" => "ballast-water-management"
}

certificates.each do |k, v|
  if (File.file?("Certificates/#{k}.pdf") or File.file?("Certificates/#{k}-#{v}.pdf"))
    p "ok: #{k}.pdf"
  else
    puts "can't find Certificates/#{k}.pdf"
  end
end

