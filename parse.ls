require! <[fs cheerio]>

files = fs.readdir-sync(\raw)map(-> "raw/#it")
all-list = []
for file in files =>
  data = fs.read-file-sync file .toString!
  $ = cheerio.load data
  clist = []
  $('.show_b_tl tr').each (i,e) -> 
    ret = []
    $(e).find("td").each (i,e) -> ret ++= [$(e).text()]
    if !ret.3 => return
    d = {date: ret.1.replace(/ /g, ""), name: ret.2, amount: parseInt(ret.3.replace(/,/g, ""))}
    clist ++= [d]
  all-list ++= clist

all-list.sort (a,b) -> 
  a = parseInt(a.date.replace(/\//g))
  b = parseInt(b.date.replace(/\//g))
  a - b

fs.write-file-sync \donate.json, JSON.stringify(all-list)

group = {}
for item in all-list
  ret = /(\d+)\/(\d+)\/\d+/.exec item.date
  if not ret => console.log "failed"
  [y,m] = [ret.1, ret.2]map -> parseInt(it)
  idx = (y - 2007 ) * 12 + m
  if !group[idx] => group[idx] = 0
  group[idx] += item.amount

fs.write-file-sync \donate-group.json, JSON.stringify(group)

sum = 0
for k,v of group
  sum += v
console.log "總金額: #sum"
