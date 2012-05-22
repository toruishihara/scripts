require 'date'
$base = "/Users/toru1/tmp/iBunko/iBunkoHD/iBunkoHD"
$src = "/Users/toru1/yendis/iBunko_Yendis/iBunkoHD"
$tar = "~/tmp/a.tar"
$exts = ["java", "xml", "png"]


flist = open($src+"/a.lst", "w")
Dir.glob($src + "/**/*").each{|fn|
  match = 0
  $exts.each { |ext|
    if (fn =~ /\.#{ext}$/) then
      match = 1
    end
  }
  if (match == 1) then
    begin
      sub = fn.sub($src, "")
      s1 = File::stat(fn)
      s2 = File::stat($base + sub)
      if (s1.size != s2.size || s1.mtime != s2.mtime) then
        printf "bup %s size:%d %d date:%d %d\n", fn, s1.size, s2.size, s1.mtime.to_i, s2.mtime.to_i
        sub2 = sub.slice(1,999)
        printf flist, "%s\n", sub2
      end
    rescue
    else
    ensure
    end
  end
}
flist.close()

zname = "MBK" + Date.today.to_s
while (File.exists?($src + "/" + zname + ".zip")) do
  zname += "x"
end

Dir.chdir($src)
system("cat a.lst | zip " + zname + ".zip -@")
