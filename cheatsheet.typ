#set page("a2", flipped: true)
#set text(
    font: "Monaco"
)

#let commandBlock(body, title: "ls [option] file") = {
    box(
        width: 100%,
        stroke: (
            paint: gray,
            thickness: 0.5pt,
        ),
        inset: 12pt,
        outset: 0pt,
        radius: 5pt,
        clip: true,
    )[
        #text(weight: "bold")[
            #raw(title)
        ]

        #set text(size: 10pt)
        #body
    ]

}


#columns(5)[
== File commands
#commandBlock(title: "ls [option] file")[
```
-a: show hidden
-A: show hidden except . and ..
-h: human readable size
-i: inode info
-l: long list format
-m: output as csv
-n: numeric uid and guid
-r: sort in reverse order
-S: sort by file size
-t: sort by modification time
```
]


#commandBlock(title: "tree [options] dir")[
```txt
-d: only directories
-f: show full paths
-P pattern: only matching pattern
-I pattern: except matching pattern
-h: print sizes in human readable way
-C: use colors
-L x: max x level depth
```
]


#commandBlock(title: "cp [options] source dest")[
```
-b: backup dest before overwrite
-r: recursive
-f: force
-l: link files instead of copy
-P: dont follow sym links
-i: interactive
-u: copy only if source newer than dest
```
]

#commandBlock(title: "mv [options] source dest")[
```
-b: backup dest before overwrite
-f: force
-i: interactive
-u: move only if source newer than dest
```
]

#commandBlock(title: "rm [options] file")[
```
-f: force
-i: interactive

rm - -foo if file name is -foo
```
]

#commandBlock(title: "tail [options] file")[
```
-f: show end of file live
-35: show last 35 lines
-q: be quiet
```
]

#commandBlock(title: "ln [options] file link")[
```
-s: sym link (hard by default)
-f: overwrite link if exists
-b: backup old link before overwrite
```
]

#commandBlock(title: "head [options] file")[
```
-35: show first 35 lines
-q: be quiet
```
]

#commandBlock(title: "tac file(s)")[
```
print files starting from last line
```
]

#commandBlock(title: "cut [options] file")[
```
-d char: use char as delimiter
-f 1,3,5: print fields 1, 3 and 5
```
]

#commandBlock(title: "chmod [options] mode file(s)")[
```
-R: recursive
```
*symbolic mode*
```
format: [ugoa][[+-=][perms]],...
example: u+x,o-wx,g-w

u: owner
g: group
o: others a: all
+: add mode
-: remove mode
=: exact mode
r: read
w: write
x: execute files and search for dirs
X: search for dirs
s: setuid or setguid
t: sticky bit
```
*numeric mode*
```
format: [0-7]1,4
example: 755

first digit: setuid(4), setguid(2)
second digit: owner perms
third digit: group perms
fourth digit: others perms

read: 4
write: 2
execute: 1
```
]

#commandBlock(title: "find path [options] [tests] [actions]")[
```
-mindepth x: ignore levels < x depth
-maxdepth y: ignore levels > y depth
```
*tests:*
```
-name "xyz*": name like xyz*
-iname "xyz*": case insensitive
-type d: only directories
-type f: only files
-mtime 0: modified < 1 day
-mtime -x: modified < x days
-mtime +x: modified > x days
-mmin: like
-mtime but in minutes
-size +100M: size > 100MB
-size -100M: size < 100MB
(M for MB, k for KB, G for GB)
-perm /o+w: writable by others
! -perm /o+r : not readable by others
```
*actions:*
```
-print: print matching
-delete: rm matching files
-exec cmd ’{}’ ; : cmd on every match
-exec cmd ’{}’ + : cmd once on all results
-exec rm -rf ’’ : remove matching items
-fprint /tmp/result: write matches to /tmp/result
```
]

#commandBlock(title: "diff [options] files")[
```
-r: recursive
-w: ignore whitespaces
-B: ignore blank lines
-q: only show file names
-x".sync*": exclude files with path like .sync*
```
]

#commandBlock(title: "grep [options] pattern files")[
```
-i: ignore case
-P: pattern is a perl regex
-m: stop after m matches
-n: also show matching line number
-R: recurse directories
-c: only show matching lines count
-exclude=glob : exclude these
-include=glob : only consider these
```
]

#commandBlock(title: "cat [options] file(s)")[
```
-v: non ascii chars except tab and eol
-T: show tabs
-t: equivalent to -vT
-E: show eol end of line
-e: equivalent to -vE
-A: equivalent to -vET
-s: remove repeat empty lines
```
]

#commandBlock(title: "uniq [options] input output")[
```
-c: prefix lines by occurrence
-d: only print duplicate lines
-u: only print unique lines
```
]

#commandBlock(title: "sort [options] file")[
```
-n: numeric sort
-b: ignore blank lines
-f: ignore case
-r: reverse order
```
]

#commandBlock(title: "tar [options] file")[
```
-f file: archive file
-c: create
-t: list
-x: extract
-C DIR: cd to DIR
-z: gzip
-j: bzip2
```
]

#commandBlock(title: "du [options] file")[
```
-c: a grand total
-h: human readable
-L: dereference sym links
-P: no dereference of sym links
-s: total for each argument
-exclude=pattern
-max-depth=N: no deeper than N levels
```
]

#commandBlock(title: "df [options] file")[
```
-h: human readable
-i: list inodes info
-P: no dereference of sym links
```
]

== Process Commands

#commandBlock(title: "ps [options]")[
```
-e: all processes
-f: full listing
-H: show hierarchy
-p pid: this process pid
-C cmd: this command name cmd
-w: wide output
-ww: to show long command lines
-l: long listing, including wchan
-o x,y,z: show columns x y z
-o user,pid,cmd: show columns user, pid command
-N: negation
-u user: processes owned by user
-u user -N: processes not owned by user
-sort=x,y: x y are columns in ps output
-sort=user: sort by user
-sort=+time: sort by cpu time asc
-sort=-time: sort by cpu time desc
-sort=size: sort by memory size
-sort=vsize: sort by vm size
```
]

#commandBlock(title: "top [options]")[
```
-d x: refresh every x seconds
-p pid1 -p pid2: only processes with
pid1 pid2
-c : show command lines
interactive commands
space: udpdate display
n: change number of displayed proces- ses
up and down: browse processes
k: kill a process
o: change order
T: sort by time
A: sort by age
P: sort by cpu
M: sort by memory
c: display/hide command line m: display/hide memory
t: display/hide cpu
f: manage list of displayed columns
up and down: move between columns
d: display/hide the selected column
q: apply and quit the field mgmt screen
```
]

#commandBlock(title: "pgrep [options] pattern")[
```
-l : show pid and process name
-a : show pid and full command line
-n : if more than one show newest
-o : if more than one show oldest
-u uid : show only processes of uid
-c : count results
```
]

== Network & Remote

#commandBlock(title: "ssh [options] user@host [\"cmd1;cmd2\"]")[
```
-2: force protocol 2
-o StrictHostKeyChecking=no: ignore remote host key change
-X: forward X11 display
```
]

#commandBlock(title: "wget [options] url")[
```
-b: run in background
-o file: print wget output in file
-o /dev/null: suppress wget output
-q: be quiet
-d: debug
-O file: save response to file
-c: resume file download
-S: print server headers
-T N: timeout after N seconds
-user=user: basic auth user
-password=pwd: basic auth password
-save-cookies file: save cookies to file
-load-cookies file: use file as cookies
-post-data=string
-post-file=file
-no-check-certificate: ignore ssl certificate
```
]

#commandBlock(title: "curl [options] url")[
```
-H header: like -H "Host: st.com"
-u <user:password>: basic http auth
-s: be silent
-S: show errors if silent mode
-L: follow new location in case 301
-data "field=value": x-www-form-urlencoded query
-data-binary data: post data as is without encoding
-data-binary @filename: post filename content as is
-X method: use PUT, GET, POST etc.
-request method: use PUT, GET, POST etc.
```
]

#commandBlock(title: "mail [options] to-address")[
```
-s subject: email with subject
-c address1,address2: cc copy
-b address1,address2: bcc copy
mail -s ’hello there’ ’joe@st.com’ < so- mefile
```
]

== Terminal

#commandBlock(title: "")[
```
(C- = Ctrl, M- = Alt)
C-c: halt current process
C-z: pause current process
bg %1: resume it in background
fg %1: resume it in foreground
jobs: list background processes
C-d: logout
C-r: search in history
C-k: remove to end of current line
C-y: paste removed text
C-w: remove a word backward
M-d: remove a word forward
C-u: remove current line
C-a: beginning of current line
C-e: end of current line
C-x C-e: edit current line in $EDITOR
```
]

]

