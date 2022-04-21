pageextension 50101 "ANMUD Sales & Rec. Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Gudfood Item Nos."; rec."Gudfood Item Nos.")
            {
                ApplicationArea = all;
            }
            field("Gudfood Order Nos."; rec."Gudfood Order Nos.")
            {
                ApplicationArea = all;
            }
        }
    }
}