namespace ClipPlatform.Interface;

enum 50101 "Customer Level" implements ICustomerLevel
{
    Extensible = true;

    value(0; " ") { Implementation = ICustomerLevel = "Customer Level - Blank"; }
    value(3; Bronze) { Implementation = ICustomerLevel = "Customer Level - Bronze"; }
    value(1; Silver) { Implementation = ICustomerLevel = "Customer Level - Silver"; }
    value(2; Gold) { Implementation = ICustomerLevel = "Customer Level - Gold"; }
}