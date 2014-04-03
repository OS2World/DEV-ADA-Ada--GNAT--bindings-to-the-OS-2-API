/*  Hider  b_*****.c and his compilatinon  */  arg fn
say 'Creation Header b_xxxxxxx.c and its compiling'
i=pos('.',fn); if i>0 then fnm=left(fn,i-1);
                      else do; fnm=fn; fn=fn || '.ali'; end
fnl=fnm || '.lst'
'gnatbind ' fn
fn='b_' || fnm || '.c'
'call adao ' fn
exit
