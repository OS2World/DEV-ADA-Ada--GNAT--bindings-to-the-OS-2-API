/* Editor Tedit */ parse arg fn
'@echo off'
i=pos('.',fn); if i>0 then fnm=left(fn,i-1);
                      else do; fnm=fn; fn=fn || '.adb'; end
'tedit' fn
