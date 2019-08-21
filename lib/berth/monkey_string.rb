module MonkeyString
  def form_date(separator = '/', decimal_point = '.')

    if self.to_s =~ /^(\d\d)(\d\d)(\d\d)(\d\d)$/ # full date and time (4)
      m = self.to_s.match /(\d\d)(\d\d)(\d\d)(\d\d)/
      x = m[1]
      x << separator + m[2] + separator + m[3] + ":" + m[4]
    elsif self.to_s =~ /^0$/ # 0 == 00:01 of today
      x = Date.today.to_s.sub(/20(\d+)-(\d+)-(\d+)/){$3 + "/" + $2}
      x << separator + "00:01"
    elsif self.to_s =~ /^(\d\d)(\d\d)$/ # time i.e. 11:11 only
      m = self.to_s.match /(\d\d)(\d\d)/
      x = Date.today.to_s.sub(/20(\d+)-(\d+)-(\d+)/){$3 + "/" + $2}
      x << separator + m[1] + ":" + m[2]
    elsif self.to_s =~ /^(\d\d?)(\d\d)(\d\d)$/ #day and time 15/[11]/15:00
      m = self.to_s.match /(\d\d?)(\d\d)(\d\d)/
      x = Date.today.to_s.sub(/20(\d+)-(\d+)-(\d+)/){m[1] + "/" + $2}
      x << separator + m[2] + ":" + m[3]
    end
    return x
  end

end
