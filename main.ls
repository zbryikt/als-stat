require! <[fs request cheerio]>
iconv = require \iconv-lite

url = \http://www.17885.com.tw/modules/group/group_content.php?Serial=123&tab=donatelist&p=


index = 1

download = ->
  while index <= 213 =>
    file = "raw/page#index.html"
    if !fs.exists-sync(file) => break
    index := index + 1
  if index > 213 => return

  console.log "fetch page #index ..."
  request { 
    url: url + index
    encoding: null
  }, (e,r,b) ->
    if r.status-code != 200 => return setTimeout download, 2000
    ret = iconv.decode(new Buffer(b), \big5)
    fs.write-file-sync file, ret
    index := index + 1
    setTimeout download, 100

download!
