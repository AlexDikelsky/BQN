scripte utf-8
let b:keymap_name=expand('<sfile>:t:r')

" Configurable prefix key; backslash by default
let p=exists('g:bqn_prefix_key')?g:bqn_prefix_key:'\'

let a ='`1234567890-= ~!@#$%^&*()_+'
let a.='qwertyuiop[]  QWERTYUIOP{} '
let a.='asdfghjkl;''\ ASDFGHJKL:"| '
let a.='zxcvbnm,./    ZXCVBNM<>?   '

let b ='˜˘¨⁼⌜´˝7∞¯•÷× ¬⎉⚇⍟◶⊘⎊⍎⍕⟨⟩√⋆'
let b.='⌽𝕨∊↑∧y⊔⊏⊐π←→  ↙𝕎⍷𝕣⍋YU⊑⊒⍳⊣⊢ '
let b.='⍉𝕤↕𝕗𝕘⊸∘○⟜⋄↩\  ↖𝕊D𝔽𝔾«J⌾»·˙| '
let b.='⥊𝕩↓∨⌊n≡∾≍≠    Z𝕏C⍒⌈N≢≤≥⇐   '

let[a,b]=map([a,b],{i,x->split(x,'\zs *')})
let a+=['<space>']|let b+=['‿']
for l in ['l','c']
 for i in range(len(a))
  exe escape(l.'no<buffer>'.p.a[i].' '.b[i],'|')
 endfor
endfor

" Add functions for making ⟨⟩ usable as a text object
function! s:aroundBQNList()
    call searchpair('⟨','','⟩', 'cW')
    normal! v%
endfunction

function! s:insideBQNList()
    call s:aroundBQNList()
    normal! loh
endfunction

for par in [get(a, index(b, '⟨')), get(a, index(b, '⟩'))]
 for l in [["a", "aroundBQNList"], ["i", "insideBQNList"]]
  exec escape("onoremap<silent><buffer>".l[0].p.par." :call <sid>".l[1]."()<cr>", "|")
 endfor
endfor

unl p a b l i par
