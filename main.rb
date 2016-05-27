lines = File.open('ips.txt') do |f|
  f.map {|line| line.gsub("\n","") }
end

out = lines.map do |line|
  mask = line.match(/\/\d+/).to_s.gsub("/","").to_i
  line.gsub!(/\/\d+/,"")
  octets = line.split(".")
  if mask >= 8 && mask < 16
    octets[-1].gsub!(/\d+/,"%")
    octets[-2].gsub!(/\d+/,"%")
    octets[-3].gsub!(/\d+/,"%")
  end
  if mask >= 16 && mask < 24
    octets[-1].gsub!(/\d+/,"%")
    octets[-2].gsub!(/\d+/,"%")
  end
  if mask >= 24 && mask < 32
    octets[-1].gsub!(/\d+/,"%")
  end
line = octets.join(".")
end


File.open("ipranges.txt", "w") do |file|
  out.each do |line|
    file.write(line.to_s + "\n")
  end
end