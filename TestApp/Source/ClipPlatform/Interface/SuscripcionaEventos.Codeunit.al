
namespace ClipPlatform.Interface;

using Microsoft.Sales.Customer;
codeunit 50154 "Suscripcion a Eventos"
{

    // [EventSubscriber(ObjectType::Table, Database::Customer, OnValidateCustomerLevelOnBeforeUnknownLevelError, '', false, false)]
    // local procedure Customer_OnValidateCustomerLevelOnBeforeUnknownLevelError(var Rec: Record Customer; xRec: Record Customer; var Handled: Boolean)
    // begin
    //     if Rec."Customer Level" <> Rec."Customer Level"::Platinium then
    //         exit;

    //     Rec.Validate("Level Discount", 20);
    //     Handled := true;
    // end;
}