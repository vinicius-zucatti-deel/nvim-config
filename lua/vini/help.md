# My own help file

## replace all string globaly

```
select files:
:args src/**/*.ts
execute command:
:argdo %s/old/new/gc | update
```

Neovim quick actions for words and text objects:

- 'c' = change (delete + insert)
- 'v' = visual select (highlight)
- 'i' = inside
- 'a' = around (including surrounding space or symbols)

ciw # change inside word (delete the word under cursor and enter insert mode)
caw # change around word (delete the word plus surrounding spaces and enter insert mode)
vi" # visually select inside double quotes (everything between the quotes)

change inner brakets

```
cib
```

view inner brakers

```
vib
```

https://github.com/kylechui/nvim-surround

The three "core" operations of add/delete/change can be done with the keymaps ys{motion}{char}, ds{char}, and cs{target}{replacement}, respectively. For the following examples, \* will denote the cursor position:

```
surr*ound_words ysiw) (surround_words)
*make strings ys$" "make strings"
[delete ar*ound me!] ds] delete around me!
remove <b>HTML t*ags</b> dst remove HTML tags
'change quot*es' cs'" "change quotes"
<b>or tag* types</b> csth1<CR> <h1>or tag types</h1>
delete(functi*on calls) dsf function calls
```
