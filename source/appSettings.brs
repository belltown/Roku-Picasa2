
Sub picasa_browse_settings()
    screen=uitkPreShowPosterMenu("","Settings")
    
    highlights=m.highlights
    settingmenu = [
        {ShortDescriptionLine1:"Slideshow Duration", ShortDescriptionLine2:"Change slideshow duration", HDPosterUrl:highlights[4], SDPosterUrl:highlights[4]},
        {ShortDescriptionLine1:"Deactivate Player", ShortDescriptionLine2:"Remove link from Picasa account", HDPosterUrl:highlights[5], SDPosterUrl:highlights[5]},
        {ShortDescriptionLine1:"About", ShortDescriptionLine2:"About the channel", HDPosterUrl:highlights[6], SDPosterUrl:highlights[6]},
    ]
    onselect = [0, m, "SlideshowSpeed","DelinkPlayer","About"]
    
    uitkDoPosterMenu(settingmenu, screen, onselect)
End Sub

Sub picasa_set_slideshow_speed()
    ssdur=RegRead("SlideshowDuration","Settings")
    if ssdur=invalid then
        durtext="not set (default 3 seconds)"
    else
        durtext=ssdur+" seconds"
    end if
    
    port = CreateObject("roMessagePort")
    screen = CreateObject("roParagraphScreen")
    screen.SetMessagePort(port)
    
    screen.AddHeaderText("Slideshow Speed")
    screen.AddParagraph("Choose your slideshow speed")
    screen.AddParagraph("Current setting: "+durtext)
    screen.AddButton(3, "3 seconds")
    screen.AddButton(5, "5 seconds")
    screen.AddButton(10, "10 seconds")
    screen.AddButton(30, "30 seconds")
    screen.AddButton(0, "Custom")
    screen.Show()
    
    while true
        msg = wait(0, screen.GetMessagePort())
        
        if type(msg) = "roParagraphScreenEvent"
            if msg.isScreenClosed()
                print "Screen closed"
                exit while                
            else if msg.isButtonPressed()
                print "Button pressed: "; msg.GetIndex(); " " msg.GetData()
                button_idx=msg.GetIndex()
                if button_idx = 0 then
                    speed=picasa_set_custom_slideshow_speed()
                else
                    speed=button_idx
                end if
                
                if speed<>invalid then
                    RegWrite("SlideshowDuration",Str(speed),"Settings")
                    m.SlideshowDuration=button_idx
                end if
                
                exit while
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
                exit while
            end if
        end if
    end while
End Sub

Function picasa_set_custom_slideshow_speed()
    port = CreateObject("roMessagePort")
    pin = CreateObject("roPinEntryDialog")
    pin.SetMessagePort(port)
    
    pin.SetTitle("Enter Custom Slideshow Speed")
    pin.SetNumPinEntryFields(3)
    pin.AddButton(0, "OK")
    pin.AddButton(1, "Cancel")
    pin.Show()
    
    while true
        msg = wait(0, pin.GetMessagePort())
        
        if type(msg) = "roPinEntryDialogEvent"
            if msg.isScreenClosed()
                print "Screen closed"
                return invalid
            else if msg.isButtonPressed()
                buttonID = msg.GetIndex()
                print "buttonID pressed: "; buttonID
                if (buttonID = 0)
                    pinCode = pin.Pin()
                    print "Got pin: " + pinCode
                    return Val(pinCode)
                else if (buttonID = 1)
                    print "Cancel Pressed"
                    pin.Close()
                    return invalid
                end if
                return Val(pin.Pin())
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
                return invalid
            end if
        end if
    end while
End Function

Sub picasa_delink()
    ans=ShowDialog2Buttons("Deactivate Player","Remove link to your Picasa account?","Confirm","Cancel")
    if ans=0 then 
        oa = Oauth()
        oa.erase()
    end if
End Sub

Sub picasa_about()
    port = CreateObject("roMessagePort")
    screen = CreateObject("roParagraphScreen")
    screen.SetMessagePort(port)
    
    screen.AddHeaderText("About the channel")
    para = ""
    para = para + "The channel is not affiliated with Google." + Chr(10) + Chr(10)
    para = para + "The Picasa Web Albums Channel was originally developed by Chris Hoffman. "
    para = para + "This version of the channel was developed by Belltown. " + Chr(10) + Chr(10)
    para = para + "If you have any questions or comments, post them in forums.roku.com in the General Discussions forum (preferably in an existing Picasa thread)."
    REM screen.AddParagraph("The Picasa Web Albums Channel was developed by Chris Hoffman.  The channel is not affiliated with Google.  If you have any questions or comments, go to forums.roku.com and send a message directly to me.  My username is hoffmcs.")
    screen.AddParagraph(para)
    screen.AddButton(1, "Back")
    screen.Show()
    
    while true
        msg = wait(0, screen.GetMessagePort())
        
        if type(msg) = "roParagraphScreenEvent"
            if msg.isScreenClosed()
                print "Screen closed"
                exit while                
            else if msg.isButtonPressed()
                print "Button pressed: "; msg.GetIndex(); " " msg.GetData()
                exit while
            else
                print "Unknown event: "; msg.GetType(); " msg: "; msg.GetMessage()
                exit while
            endif
        endif
    end while
End Sub

