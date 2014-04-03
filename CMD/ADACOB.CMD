/*  Hider  b_*****.c and his compilatinon  b_*****.obj */  arg fn
say 'Creation Header b_xxxxxxx.c and its compiling'
i=pos('.',fn); if i>0 then fnm=left(fn,i-1);
                      else do; fnm=fn; fn=fn || '.ali'; end
fnl=fnm || '.lst'
'gnatbind ' fn
if rc>0 then exit
fn='b_' || fnm || '.c'
'call adaobj ' fn
exit
