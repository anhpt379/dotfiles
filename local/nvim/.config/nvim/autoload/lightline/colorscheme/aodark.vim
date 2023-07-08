let s:mono0   = ['#0c0c0c', 236]
let s:mono1   = ['#262626', 238]
let s:mono2   = ['#555555', 243]
let s:mono3   = ['#eeeeee', 255]

let s:yellow  = ['#deb246', 180]
let s:red     = ['#e22f62', 168]
let s:magenta = ['#b954e1', 176]
let s:blue    = ['#28c9ff', 75 ]
let s:cyan    = ['#3cc8b4', 73 ]
let s:green   = ['#5FAE4D', 114]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left     = [[s:mono0, s:green], [s:mono3, s:mono2]]
let s:p.normal.middle   = [[s:mono3, s:mono1]]
let s:p.normal.right    = [[s:mono0, s:mono3], [s:mono3, s:mono2]]

let s:p.normal.error    = [[s:mono0, s:red]]
let s:p.normal.warning  = [[s:mono0, s:yellow]]

let s:p.inactive.left   = [[s:mono3, s:mono2], [s:mono3, s:mono2]]
let s:p.inactive.middle = [[s:mono3, s:mono1]]
let s:p.inactive.right  = [[s:mono0, s:mono3], [s:mono3, s:mono2]]

let s:p.insert.left     = [[s:mono0, s:blue], [s:mono3, s:mono2]]
let s:p.replace.left    = [[s:mono0, s:red], [s:mono3, s:mono2]]
let s:p.visual.left     = [[s:mono0, s:yellow], [s:mono3, s:mono2]]

let s:p.tabline.left    = [[s:mono3, s:mono2]]
let s:p.tabline.tabsel  = [[s:mono0, s:mono3]]
let s:p.tabline.middle  = [[s:mono2, s:mono1]]
let s:p.tabline.right   = [[s:mono0, s:mono3]]

let g:lightline#colorscheme#aodark#palette = lightline#colorscheme#flatten(s:p)
