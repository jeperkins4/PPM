let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =BackwardsSnippet()
map! <S-Insert> <MiddleMouse>
nnoremap  :FuzzyFinderTextMate
snoremap <silent> 	 i<Right>=TriggerSnippet()
snoremap  b<BS>
noremap s :TCommentAs =&ft_
noremap n :TCommentAs =&ft 
noremap a :TCommentAs 
noremap b :TCommentBlock
vnoremap <silent> r :TCommentRight
vnoremap <silent> i :TCommentInline
nnoremap <silent> r :TCommentRight
onoremap <silent> r :TCommentRight
noremap   :TComment 
noremap <silent> p m`vip:TComment``
vnoremap <silent>  :TCommentMaybeInline
nnoremap <silent>  :TComment
onoremap <silent>  :TComment
snoremap % b<BS>%
snoremap ' b<BS>'
noremap - $
inoremap ï o
noremap D 
noremap H 8<Down>
nmap K :Search "\b\b"
noremap L N
noremap N 
xmap S <Plug>VSurround
nnoremap S :
snoremap S :
onoremap S :
noremap T 8<Up>
snoremap U b<BS>U
vmap [% [%m'gv``
snoremap \ b<BS>\
noremap \_s :TCommentAs =&ft_
noremap \_n :TCommentAs =&ft 
noremap \_a :TCommentAs 
noremap \_b :TCommentBlock
vnoremap <silent> \_r :TCommentRight
nnoremap <silent> \_r :TCommentRight
onoremap <silent> \_r :TCommentRight
vnoremap <silent> \_i :TCommentInline
noremap \_  :TComment 
noremap <silent> \_p vip:TComment
vnoremap <silent> \__ :TCommentMaybeInline
nnoremap <silent> \__ :TComment
onoremap <silent> \__ :TComment
nmap <silent> \slr :DBListVar
xmap <silent> \sa :DBVarRangeAssign
nmap <silent> \sap :'<,'>DBVarRangeAssign
nmap <silent> \sal :.,.DBVarRangeAssign
nmap <silent> \sas :1,$DBVarRangeAssign
nmap \so <Plug>DBOrientationToggle
nmap \sh <Plug>DBHistory
nmap \slv <Plug>DBListView
nmap \slp <Plug>DBListProcedure
nmap \slt <Plug>DBListTable
xmap <silent> \slc :exec 'DBListColumn "'.DB_getVisualBlock().'"'
nmap \slc <Plug>DBListColumn
nmap \sbp <Plug>DBPromptForBufferParameters
nmap \sdpa <Plug>DBDescribeProcedureAskName
xmap <silent> \sdp :exec 'DBDescribeProcedure "'.DB_getVisualBlock().'"'
nmap \sdp <Plug>DBDescribeProcedure
nmap \sdta <Plug>DBDescribeTableAskName
xmap <silent> \sdt :exec 'DBDescribeTable "'.DB_getVisualBlock().'"'
nmap \sdt <Plug>DBDescribeTable
xmap <silent> \sT :exec 'DBSelectFromTableTopX "'.DB_getVisualBlock().'"'
nmap \sT <Plug>DBSelectFromTopXTable
nmap \sta <Plug>DBSelectFromTableAskName
nmap \stw <Plug>DBSelectFromTableWithWhere
xmap <silent> \st :exec 'DBSelectFromTable "'.DB_getVisualBlock().'"'
nmap \st <Plug>DBSelectFromTable
nmap <silent> \sep :'<,'>DBExecRangeSQL
nmap <silent> \sel :.,.DBExecRangeSQL
nmap <silent> \sea :1,$DBExecRangeSQL
nmap \sE <Plug>DBExecSQLUnderTopXCursor
nmap \se <Plug>DBExecSQLUnderCursor
xmap \sE <Plug>DBExecVisualTopXSQL
xmap \se <Plug>DBExecVisualSQL
map <silent> \f <Plug>SimpleFold_Foldsearch
nmap <silent> \p :NERDTreeToggle
map \t :FuzzyFinderTextMate
vmap ]% ]%m'gv``
snoremap ^ b<BS>^
noremap _ ^
snoremap ` b<BS>`
vmap a% [%v]%
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
noremap d h
nmap gx <Plug>NetrwBrowseX
noremap <silent> gCc :let w:tcommentPos = getpos(".") | set opfunc=TCommentOperatorLineAnywayg@$
noremap <silent> gC :let w:tcommentPos = getpos(".") | set opfunc=TCommentOperatorAnywayg@
noremap <silent> gcc :let w:tcommentPos = getpos(".") | set opfunc=TCommentOperatorLineg@$
noremap <silent> gc :let w:tcommentPos = getpos(".") | set opfunc=TCommentOperatorg@
noremap h j
noremap j d
noremap l n
noremap n l
xmap s <Plug>Vsurround
nnoremap s :
snoremap s :
onoremap s :
noremap t k
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
map <S-Insert> <MiddleMouse>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =TriggerSnippet()
inoremap <silent> 	 =ShowAvailableSnips()
imap  <Plug>DiscretionaryEnd
imap  <Plug>Isurround
imap  <Plug>AlwaysEnd
inoremap s :TCommentAs =&ft_
inoremap n :TCommentAs =&ft 
inoremap a :TCommentAs 
inoremap b :TCommentBlock
inoremap <silent> r :TCommentRight
inoremap   :TComment 
inoremap <silent> p :norm! m`vip:TComment``
inoremap <silent>  :TComment
map <silent> î :cn 
map <silent> ð :cp 
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set autowrite
set background=dark
set backspace=2
set cindent
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set clipboard=autoselect,exclude:cons\\|linux,unnamed
set completefunc=syntaxcomplete#Complete
set confirm
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set formatoptions=tcqr
set helplang=en
set incsearch
set iskeyword=@,48-57,_,192-255,$
set laststatus=2
set listchars=tab:\ \ ,eol:$,trail:~,extends:>,precedes:<
set mouse=a
set printoptions=paper:letter
set ruler
set runtimepath=~/.vim,/var/lib/vim/addons,/usr/share/vim/vimfiles,/usr/share/vim/vim72,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,~/.vim/after
set shiftwidth=2
set showmatch
set smarttab
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=2
set termencoding=utf-8
set timeoutlen=250
set window=52
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/development/privateprison
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +12 spec/controllers/incidents_controller_spec.rb
badd +6 ~/.vim/snippets/ruby-rspec/rswp.snippet
badd +6 app/controllers/incidents_controller.rb
badd +10 spec/controllers/position_numbers_controller_spec.rb
badd +16 app/views/incidents/index.rhtml
badd +10 lib/pagination_link_renderer.rb
badd +4 config/environments/development.rb
badd +6 app/controllers/application_controller.rb
badd +0 spec/views/incidents/index_spec.rb
badd +1 app/models/incident.rb
silent! argdel *
edit app/controllers/incidents_controller.rb
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 102 + 102) / 205)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 102 + 102) / 205)
exe '3resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 102 + 102) / 205)
exe '4resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 4resize ' . ((&columns * 102 + 102) / 205)
argglobal
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=:0,p0,t0
setlocal cinwords=if,else,while,do,for,switch,case
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=<SNR>16_SimpleFold_FoldText()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=ri\ -T
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/development/privateprison,~/development/privateprison/app,~/development/privateprison/app/models,~/development/privateprison/app/controllers,~/development/privateprison/app/helpers,~/development/privateprison/config,~/development/privateprison/lib,~/development/privateprison/app/views,~/development/privateprison/app/views/incidents,~/development/privateprison/public,~/development/privateprison/spec,~/development/privateprison/spec/models,~/development/privateprison/spec/controllers,~/development/privateprison/spec/helpers,~/development/privateprison/spec/views,~/development/privateprison/spec/lib,~/development/privateprison/app/*,~/development/privateprison/vendor,~/development/privateprison/vendor/plugins/*/lib,~/development/privateprison/vendor/plugins/*/test,~/development/privateprison/vendor/rails/*/lib,~/development/privateprison/vendor/rails/*/test,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/i486-linux,/usr/local/lib/site_ruby/1.8/i386-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i486-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i486-linux,/usr/lib/ruby/1.8/i386-linux,,~/.gem/ruby/1.8/gems/activerecord-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.3.3/lib,~/.gem/ruby/1.8/gems/autotest-rails-4.1.0/lib,~/.gem/ruby/1.8/gems/bcrypt-ruby-2.0.5/lib,~/.gem/ruby/1.8/gems/btelles-faker-0.3.3/lib,~/.gem/ruby/1.8/gems/builder-2.1.2/lib,~/.gem/ruby/1.8/gems/data_mapper-0.9.11/lib,~/.gem/ruby/1.8/gems/diff-lcs-1.1.2/lib,~/.gem/ruby/1.8/gems/dm-aggregates-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-cli-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-core-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-is-tree-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-migrations-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-observer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-serializer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-timestamps-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-types-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-validations-0.9.11/lib,~/.gem/ruby/1.8/gems/fastercsv-1.2.3/lib,~/.gem/ruby/1.8/gems/francois-classifier-1.3.6/lib,~/.gem/ruby/1.8/gems/gtk2applib-2.4.0/.,~/.gem/ruby/1.8/gems/integrity-0.1.11/lib,~/.gem/ruby/1.8/gems/jeweler-1.0.2/lib,~/.gem/ruby/1.8/gems/merb-core-1.0.12/lib,~/.gem/ruby/1.8/gems/merb_datamapper-1.0.12/lib,~/.gem/ruby/1.8/gems/mislav-will_paginate-2.3.11/lib,~/.gem/ruby/1.8/gems/mmangino-facebooker-1.0.47/lib,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/ext,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/lib,~/.gem/ruby/1.8/gems/ruby-stemmer-0.5.3/lib,~/.gem/ruby/1.8/gems/sinatra-authorization-1.0.0/lib,~/.gem/ruby/1.8/gems/spork-0.5.7/lib,~/.gem/ruby/1.8/gems/term-ansicolor-1.0.4/lib,~/.gem/ruby/1.8/gems/treetop-1.3.0/lib,~/.gem/ruby/1.8/gems/uuidtools-2.0.0/lib,/usr/lib/ruby/gems/1.8/gems/FixedWidthFields-0.1/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/ext,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib/case_sensitive_require,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.3/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-1.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-1.13.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionwebservice-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-1.15.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/ac
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{RailsStatusline()}%=%-16(\ %l,%c-%v\ %)%P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=~/development/privateprison/tmp/tags,./tags,./TAGS,tags,TAGS,~/development/privateprison/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
1,1fold
1,4fold
8,10fold
18,21fold
5,23fold
24,35fold
36,40fold
41,45fold
46,61fold
62,82fold
90,93fold
83,95fold
1
normal zo
1
normal zo
1
normal zo
5
normal zo
8
normal zo
18
normal zo
5
normal zo
let s:l = 20 - ((19 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
20
normal! 049l
wincmd w
argglobal
edit app/views/incidents/index.rhtml
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=:0,p0,t0
setlocal cinwords=if,else,while,do,for,switch,case
setlocal comments=:#
setlocal commentstring=<%#%s%>
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'eruby'
setlocal filetype=eruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetErubyIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],o,O,!^F,=end,=else,=elsif,=rescue,=ensure,=when
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/development/privateprison,~/development/privateprison/app,~/development/privateprison/app/models,~/development/privateprison/app/controllers,~/development/privateprison/app/helpers,~/development/privateprison/config,~/development/privateprison/lib,~/development/privateprison/app/views,~/development/privateprison/app/views/incidents,~/development/privateprison/public,~/development/privateprison/spec,~/development/privateprison/spec/models,~/development/privateprison/spec/controllers,~/development/privateprison/spec/helpers,~/development/privateprison/spec/views,~/development/privateprison/spec/lib,~/development/privateprison/app/*,~/development/privateprison/vendor,~/development/privateprison/vendor/plugins/*/lib,~/development/privateprison/vendor/plugins/*/test,~/development/privateprison/vendor/rails/*/lib,~/development/privateprison/vendor/rails/*/test,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/i486-linux,/usr/local/lib/site_ruby/1.8/i386-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i486-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i486-linux,/usr/lib/ruby/1.8/i386-linux,,~/.gem/ruby/1.8/gems/activerecord-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.3.3/lib,~/.gem/ruby/1.8/gems/autotest-rails-4.1.0/lib,~/.gem/ruby/1.8/gems/bcrypt-ruby-2.0.5/lib,~/.gem/ruby/1.8/gems/btelles-faker-0.3.3/lib,~/.gem/ruby/1.8/gems/builder-2.1.2/lib,~/.gem/ruby/1.8/gems/data_mapper-0.9.11/lib,~/.gem/ruby/1.8/gems/diff-lcs-1.1.2/lib,~/.gem/ruby/1.8/gems/dm-aggregates-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-cli-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-core-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-is-tree-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-migrations-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-observer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-serializer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-timestamps-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-types-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-validations-0.9.11/lib,~/.gem/ruby/1.8/gems/fastercsv-1.2.3/lib,~/.gem/ruby/1.8/gems/francois-classifier-1.3.6/lib,~/.gem/ruby/1.8/gems/gtk2applib-2.4.0/.,~/.gem/ruby/1.8/gems/integrity-0.1.11/lib,~/.gem/ruby/1.8/gems/jeweler-1.0.2/lib,~/.gem/ruby/1.8/gems/merb-core-1.0.12/lib,~/.gem/ruby/1.8/gems/merb_datamapper-1.0.12/lib,~/.gem/ruby/1.8/gems/mislav-will_paginate-2.3.11/lib,~/.gem/ruby/1.8/gems/mmangino-facebooker-1.0.47/lib,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/ext,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/lib,~/.gem/ruby/1.8/gems/ruby-stemmer-0.5.3/lib,~/.gem/ruby/1.8/gems/sinatra-authorization-1.0.0/lib,~/.gem/ruby/1.8/gems/spork-0.5.7/lib,~/.gem/ruby/1.8/gems/term-ansicolor-1.0.4/lib,~/.gem/ruby/1.8/gems/treetop-1.3.0/lib,~/.gem/ruby/1.8/gems/uuidtools-2.0.0/lib,/usr/lib/ruby/gems/1.8/gems/FixedWidthFields-0.1/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/ext,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib/case_sensitive_require,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.3/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-1.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-1.13.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionwebservice-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-1.15.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/ac
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{RailsStatusline()}%=%-16(\ %l,%c-%v\ %)%P
setlocal suffixesadd=.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.rb,.css,.js,.html,.yml,.csv
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'eruby'
setlocal syntax=eruby
endif
setlocal tabstop=2
setlocal tags=~/development/privateprison/tmp/tags,./tags,./TAGS,tags,TAGS,~/development/privateprison/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 16 - ((15 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 04l
wincmd w
argglobal
edit spec/controllers/incidents_controller_spec.rb
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=:0,p0,t0
setlocal cinwords=if,else,while,do,for,switch,case
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,.,/,:
setlocal keywordprg=ri\ -T
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/development/privateprison,~/development/privateprison/app,~/development/privateprison/app/models,~/development/privateprison/app/controllers,~/development/privateprison/app/helpers,~/development/privateprison/config,~/development/privateprison/lib,~/development/privateprison/app/views,~/development/privateprison/app/views/incidents,~/development/privateprison/public,~/development/privateprison/spec,~/development/privateprison/spec/models,~/development/privateprison/spec/controllers,~/development/privateprison/spec/helpers,~/development/privateprison/spec/views,~/development/privateprison/spec/lib,~/development/privateprison/app/*,~/development/privateprison/vendor,~/development/privateprison/vendor/plugins/*/lib,~/development/privateprison/vendor/plugins/*/test,~/development/privateprison/vendor/rails/*/lib,~/development/privateprison/vendor/rails/*/test,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/i486-linux,/usr/local/lib/site_ruby/1.8/i386-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i486-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i486-linux,/usr/lib/ruby/1.8/i386-linux,,~/.gem/ruby/1.8/gems/activerecord-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.3.3/lib,~/.gem/ruby/1.8/gems/autotest-rails-4.1.0/lib,~/.gem/ruby/1.8/gems/bcrypt-ruby-2.0.5/lib,~/.gem/ruby/1.8/gems/btelles-faker-0.3.3/lib,~/.gem/ruby/1.8/gems/builder-2.1.2/lib,~/.gem/ruby/1.8/gems/data_mapper-0.9.11/lib,~/.gem/ruby/1.8/gems/diff-lcs-1.1.2/lib,~/.gem/ruby/1.8/gems/dm-aggregates-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-cli-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-core-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-is-tree-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-migrations-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-observer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-serializer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-timestamps-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-types-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-validations-0.9.11/lib,~/.gem/ruby/1.8/gems/fastercsv-1.2.3/lib,~/.gem/ruby/1.8/gems/francois-classifier-1.3.6/lib,~/.gem/ruby/1.8/gems/gtk2applib-2.4.0/.,~/.gem/ruby/1.8/gems/integrity-0.1.11/lib,~/.gem/ruby/1.8/gems/jeweler-1.0.2/lib,~/.gem/ruby/1.8/gems/merb-core-1.0.12/lib,~/.gem/ruby/1.8/gems/merb_datamapper-1.0.12/lib,~/.gem/ruby/1.8/gems/mislav-will_paginate-2.3.11/lib,~/.gem/ruby/1.8/gems/mmangino-facebooker-1.0.47/lib,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/ext,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/lib,~/.gem/ruby/1.8/gems/ruby-stemmer-0.5.3/lib,~/.gem/ruby/1.8/gems/sinatra-authorization-1.0.0/lib,~/.gem/ruby/1.8/gems/spork-0.5.7/lib,~/.gem/ruby/1.8/gems/term-ansicolor-1.0.4/lib,~/.gem/ruby/1.8/gems/treetop-1.3.0/lib,~/.gem/ruby/1.8/gems/uuidtools-2.0.0/lib,/usr/lib/ruby/gems/1.8/gems/FixedWidthFields-0.1/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/ext,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib/case_sensitive_require,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.3/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-1.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-1.13.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionwebservice-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-1.15.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/ac
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{RailsStatusline()}%=%-16(\ %l,%c-%v\ %)%P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=~/development/privateprison/tmp/tags,./tags,./TAGS,tags,TAGS,~/development/privateprison/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 15 - ((14 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0
wincmd w
argglobal
edit spec/views/incidents/index_spec.rb
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
nnoremap <buffer> <silent> <Plug>RailsTabFind :RTfind
nnoremap <buffer> <silent> <Plug>RailsVSplitFind :RVfind
nnoremap <buffer> <silent> <Plug>RailsSplitFind :RSfind
nnoremap <buffer> <silent> <Plug>RailsFind :REfind
nnoremap <buffer> <silent> <Plug>RailsRelated :R
nnoremap <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=RubyBalloonexpr()
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=:0,p0,t0
setlocal cinwords=if,else,while,do,for,switch,case
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=^\\s*def\\s\\+\\(self\\.\\)\\=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
setlocal expandtab
if &filetype != 'ruby'
setlocal filetype=ruby
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=GetRubyIndent()
setlocal indentkeys=0{,0},0),0],!^F,o,O,e,=end,=elsif,=when,=ensure,=rescue,==begin,==end
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,$
setlocal keywordprg=ri\ -T
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=rubycomplete#Complete
setlocal path=.,~/development/privateprison,~/development/privateprison/app,~/development/privateprison/app/models,~/development/privateprison/app/controllers,~/development/privateprison/app/helpers,~/development/privateprison/config,~/development/privateprison/lib,~/development/privateprison/app/views,~/development/privateprison/spec,~/development/privateprison/spec/models,~/development/privateprison/spec/controllers,~/development/privateprison/spec/helpers,~/development/privateprison/spec/views,~/development/privateprison/spec/lib,~/development/privateprison/app/*,~/development/privateprison/vendor,~/development/privateprison/vendor/plugins/*/lib,~/development/privateprison/vendor/plugins/*/test,~/development/privateprison/vendor/rails/*/lib,~/development/privateprison/vendor/rails/*/test,/usr/local/lib/site_ruby/1.8,/usr/local/lib/site_ruby/1.8/i486-linux,/usr/local/lib/site_ruby/1.8/i386-linux,/usr/local/lib/site_ruby,/usr/lib/ruby/vendor_ruby/1.8,/usr/lib/ruby/vendor_ruby/1.8/i486-linux,/usr/lib/ruby/vendor_ruby,/usr/lib/ruby/1.8,/usr/lib/ruby/1.8/i486-linux,/usr/lib/ruby/1.8/i386-linux,,~/.gem/ruby/1.8/gems/activerecord-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.1.2/lib,~/.gem/ruby/1.8/gems/activesupport-2.3.3/lib,~/.gem/ruby/1.8/gems/autotest-rails-4.1.0/lib,~/.gem/ruby/1.8/gems/bcrypt-ruby-2.0.5/lib,~/.gem/ruby/1.8/gems/btelles-faker-0.3.3/lib,~/.gem/ruby/1.8/gems/builder-2.1.2/lib,~/.gem/ruby/1.8/gems/data_mapper-0.9.11/lib,~/.gem/ruby/1.8/gems/diff-lcs-1.1.2/lib,~/.gem/ruby/1.8/gems/dm-aggregates-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-cli-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-core-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-is-tree-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-migrations-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-observer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-serializer-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-timestamps-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-types-0.9.11/lib,~/.gem/ruby/1.8/gems/dm-validations-0.9.11/lib,~/.gem/ruby/1.8/gems/fastercsv-1.2.3/lib,~/.gem/ruby/1.8/gems/francois-classifier-1.3.6/lib,~/.gem/ruby/1.8/gems/gtk2applib-2.4.0/.,~/.gem/ruby/1.8/gems/integrity-0.1.11/lib,~/.gem/ruby/1.8/gems/jeweler-1.0.2/lib,~/.gem/ruby/1.8/gems/merb-core-1.0.12/lib,~/.gem/ruby/1.8/gems/merb_datamapper-1.0.12/lib,~/.gem/ruby/1.8/gems/mislav-will_paginate-2.3.11/lib,~/.gem/ruby/1.8/gems/mmangino-facebooker-1.0.47/lib,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/ext,~/.gem/ruby/1.8/gems/nokogiri-1.3.2/lib,~/.gem/ruby/1.8/gems/ruby-stemmer-0.5.3/lib,~/.gem/ruby/1.8/gems/sinatra-authorization-1.0.0/lib,~/.gem/ruby/1.8/gems/spork-0.5.7/lib,~/.gem/ruby/1.8/gems/term-ansicolor-1.0.4/lib,~/.gem/ruby/1.8/gems/treetop-1.3.0/lib,~/.gem/ruby/1.8/gems/uuidtools-2.0.0/lib,/usr/lib/ruby/gems/1.8/gems/FixedWidthFields-0.1/lib,/usr/lib/ruby/gems/1.8/gems/GeoRuby-1.3.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/lib,/usr/lib/ruby/gems/1.8/gems/ParseTree-3.0.4/test,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/ext,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib,/usr/lib/ruby/gems/1.8/gems/RedCloth-4.1.1/lib/case_sensitive_require,/usr/lib/ruby/gems/1.8/gems/RubyInline-3.8.2/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.3/lib,/usr/lib/ruby/gems/1.8/gems/ZenTest-4.1.4/lib,/usr/lib/ruby/gems/1.8/gems/abstract-1.0.0/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-1.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionmailer-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-1.13.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/actionpack-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/actionwebservice-1.2.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-1.15.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.1.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.2/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.3/lib,/usr/lib/ruby/gems/1.8/gems/activerecord-2.3.4/lib,/usr/lib/ruby/gems/1.8/gems/activeresource-2.1.2/lib,/usr/lib/
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%<%f\ %h%m%r%{RailsStatusline()}%=%-16(\ %l,%c-%v\ %)%P
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.mn,.yml,.csv,.rake,s.rb
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'ruby'
setlocal syntax=ruby
endif
setlocal tabstop=2
setlocal tags=~/development/privateprison/tmp/tags,./tags,./TAGS,tags,TAGS,~/development/privateprison/tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
silent! normal! zE
let s:l = 11 - ((10 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 03l
wincmd w
4wincmd w
exe '1resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 102 + 102) / 205)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 102 + 102) / 205)
exe '3resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 102 + 102) / 205)
exe '4resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 4resize ' . ((&columns * 102 + 102) / 205)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
