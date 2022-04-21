xmlport 50100 "Export Gudfood Order"
{
    UseDefaultNamespace = true;
    Direction = Export;
    Caption = 'Export Gudfood Order';

    schema
    {
        textelement(Root)
        {
            XmlName = 'Root';
            tableelement(GudfoodOrderHeader; "Gudfood Order Header")
            {
                fieldattribute(No; GudfoodOrderHeader."No.")
                {

                }
                fieldattribute("Sell-toCustomerNo."; GudfoodOrderHeader."Sell- to Customer No.")
                {

                }
                fieldattribute("Sell-toCustomerName"; GudfoodOrderHeader."Sell- to Customer Name")
                {

                }
                fieldattribute(DateCreated; GudfoodOrderHeader."Date Created")
                {

                }
                fieldattribute(TotalQuantity; GudfoodOrderHeader."Total Qty.")
                {

                }
                fieldattribute(TotalAmount; GudfoodOrderHeader."Total Amount")
                {

                }
                tableelement(GudfoodOrderLine; "Gudfood Order Line")
                {
                    LinkTable = GudfoodOrderHeader;
                    LinkFields = "Order No." = field("No.");
                    fieldattribute("OrderNo."; GudfoodOrderLine."Order No.")
                    {

                    }
                    fieldattribute("LineNo."; GudfoodOrderLine."Line No.")
                    {

                    }
                    fieldattribute("Sell-toCustomerNo."; GudfoodOrderLine."Sell- to Customer No.")
                    {

                    }
                    fieldattribute(DateCreated; GudfoodOrderLine."Date Created")
                    {

                    }
                    fieldattribute("ItemNo."; GudfoodOrderLine."Item No.")
                    {

                    }
                    fieldattribute(ItemType; GudfoodOrderLine."Item Type")
                    {

                    }
                    fieldattribute(Description; GudfoodOrderLine.Description)
                    {

                    }
                    fieldattribute(Quantity; GudfoodOrderLine.Quantity)
                    {

                    }
                    fieldattribute(UnitPrice; GudfoodOrderLine."Unit Price")
                    {

                    }
                    fieldattribute(Amount; GudfoodOrderLine.Amount)
                    {

                    }
                }
            }
        }
    }
}
