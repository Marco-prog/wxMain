#include <wx/wx.h>
#include "MainFrame.h"

// Applicazione wxWidgets
class MyApp : public wxApp
{
public:
    virtual bool OnInit();
};

wxIMPLEMENT_APP(MyApp);

bool MyApp::OnInit()
{
    MainFrame* frame = new MainFrame(nullptr);
    frame->Show(true);	
    return true;
}
