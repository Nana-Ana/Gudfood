tableextension 50100 "ANMUD Sales & Rec. Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(70001; "Gudfood Order Nos."; Code[20])
        {
            Caption = 'Gudfood Order Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(70002; "Gudfood Item Nos."; Code[20])
        {
            Caption = 'Gudfood Item Nos.';
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }
}