report 50100 "Gudfood Order Report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\GudfoodOrderReport.rdlc';

    dataset
    {
        dataitem("Gudfood Order Header"; "Gudfood Order Header")
        {
            RequestFilterFields = "No.";
            column(DateCreated_GudfoodOrderHeader; "Gudfood Order Header"."Date Created")
            {
            }
            column(SelltoCustomerNo_GudfoodOrderHeader; "Gudfood Order Header"."Sell- to Customer No.")
            {
            }
            column(SelltoCustomerName_GudfoodOrderHeader; "Gudfood Order Header"."Sell- to Customer Name")
            {
            }
            column(TotalAmount_GudfoodOrderHeader; "Gudfood Order Header"."Total Amount")
            {

            }
            column(UserID; USERID)
            {

            }

            dataitem("Gudfood Order Line"; "Gudfood Order Line")
            {
                DataItemTableView = sorting("Order No.", "Line No.") order(Ascending);
                DataItemLinkReference = "Gudfood Order Header";
                DataItemLink = "Order No." = field("No.");
                PrintOnlyIfDetail = false;
                column(ItemNo_GudfoodOrderLine; "Gudfood Order Line"."Item No.")
                {

                }
                column(ItemType_GudfoodOrderLine; "Gudfood Order Line"."Item Type")
                {

                }
                column(Description_GudfoodOrderLine; "Gudfood Order Line".Description)
                {

                }
                column(Quantity_GudfoodOrderLine; "Gudfood Order Line".Quantity)
                {

                }
                column(UnitPrice_GudfoodOrderLine; "Gudfood Order Line"."Unit Price")
                {

                }
                column(Amount_GudfoodOrderLine; "Gudfood Order Line".Amount)
                {

                }
            }
        }
    }
}
