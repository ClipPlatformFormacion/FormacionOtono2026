namespace ClipPlatform.Training.Sales;

using Microsoft.Sales.History;

reportextension 50100 "Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(Training_Edition; "Training Edition") { }
        }
    }

    rendering
    {
        layout(TrainingWordLayout)
        {
            Type = Word;
            LayoutFile = '.\Source\ClipPlatform\Training\Sales\TrainingWordLayout.docx';
        }
    }
}