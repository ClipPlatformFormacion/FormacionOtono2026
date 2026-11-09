namespace ClipPlatform.Training.Test;

using ClipPlatform.Training.MasterData;
using ClipPlatform.Training.Setup;
using Microsoft.Projects.Resources.Journal;
using Microsoft.Projects.Resources.Ledger;
using Microsoft.Sales.Document;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Sales.History;
using System.TestLibraries.Utilities;

codeunit 50152 "Training Test"
{
    Subtype = Test;
    TestPermissions = Disabled;

    [Test]
    procedure Training001()
    var
        Training: Record Training;
        Resource: Record Resource;
        TrainingSetup: Record "Training Setup";
        LibraryAssert: Codeunit "Library Assert";
        LibraryTraining: Codeunit "Library - Training";
    begin
        // [Scenario] Cuando se vincula una formación a un recurso, el nombre, precio y bloqueado se copian de la formacion. 
        //            La unidad de medida y grupos contables se copia de la configuración

        // [Given] Una formación con Nombre y Precio
        //          La configuración de la formación con unidad de medida y grupos contables
        //          Un recurso

        Training := LibraryTraining.CreateTraining();
        Resource := LibraryTraining.CreateResource();

        // [When] Vinculamos la formación al recurso
        Resource.Validate("Training No.", Training."No.");

        // [Then] El recurso tiene información proveniente de la formación y de la configuración        
        LibraryAssert.AreEqual(Training.Name, Resource.Name, 'El nombre no es correcto');
        LibraryAssert.AreEqual(Training.Price, Resource."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Training.Blocked, Resource.Blocked, 'El bloqueado no es correcto');
        TrainingSetup.Get();
        LibraryAssert.AreEqual(TrainingSetup."Base Unit of Measure", Resource."Base Unit of Measure", 'La UMB no es correcta');
        LibraryAssert.AreEqual(TrainingSetup."Gen. Prod. Posting Group", Resource."Gen. Prod. Posting Group", 'El grupo registro producto no es correcto');
        LibraryAssert.AreEqual(TrainingSetup."VAT Prod. Posting Group", Resource."VAT Prod. Posting Group", 'El grupo de IVA no es correcto');
    end;

    [Test]
    procedure CannotBoundTheSameTrainingToTwoResources()
    var
        Training: Record Training;
        Resource1: Record Resource;
        Resource2: Record Resource;
        LibraryAssert: Codeunit "Library Assert";
        LibraryTraining: Codeunit "Library - Training";
        TrainingLinkedToAnotherResourceErr: TextConst ENU = 'Training %1 is already linked to Resource %2',
                        ESP = 'La formación %1 ya está vinculada con el recurso %2';
    begin
        // [Scenario] No se puede vincular la misma formación a 2 recursos distintos

        // [Given] Una formación
        //         Dos recursos
        //         La formación vinculada al primer recurso
        Training := LibraryTraining.CreateTraining();
        Resource1 := LibraryTraining.CreateResource(Training."No.");
        Resource2 := LibraryTraining.CreateResource();

        // [When] Se vincula la formación al segundo recurso
        asserterror Resource2.Validate("Training No.", Training."No.");

        // [Then] Se tiene que producir un Error
        LibraryAssert.AreEqual(StrSubstNo(TrainingLinkedToAnotherResourceErr, Training."No.", Resource1."No."), GetLastErrorText(), 'El error no es el esperado');
    end;

    [Test]
    procedure SelectingAResourceOnSalesLineFillsTrainingNo()
    var
        Training: Record Training;
        Resource: Record Resource;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryTraining: Codeunit "Library - Training";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [Scenario] Al seleccionar un recurso vinculado a formación en una línea de venta
        //              el sistema rellena el campo Nº formación

        // [Given] Una formación
        //          Un recurso vinculado a la formación
        //          Un pedido de venta para un cliente cualquiera
        //          Una línea de venta de tipo Recurso
        Training := LibraryTraining.CreateTraining();
        Resource := LibraryTraining.CreateResource(Training."No.");
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Resource);
        SalesLine.Modify(true);

        // [When] Cuando se selecciona el recurso en la línea de venta
        SalesLine.Validate("No.", Resource."No.");

        // [Then] En la línea de venta se ha rellenado el campo Nº formación
        LibraryAssert.AreEqual(Training."No.", SalesLine."Training No.", 'Nº formación incorrecto');
    end;

    [Test]
    procedure CustomFieldsOnSalesShipmentLineFillCorrectly()
    var
        Training: Record Training;
        Resource: Record Resource;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        LibraryTraining: Codeunit "Library - Training";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        DocumentNo: Code[20];
    begin
        // [Scenario] Los campos personalizados en la línea de albaranes de ventas se rellenan correctamente

        // [Given] Una formación
        //          Un recurso vinculado a la formación
        //          Un pedido de venta para un cliente cualquiera
        //          Una línea de venta para el recurso, añadiéndole la edición
        Training := LibraryTraining.CreateTraining();
        Resource := LibraryTraining.CreateResource(Training."No.");
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Resource);
        SalesLine.Validate("No.", Resource."No.");
        SalesLine.Validate("Training Edition", LibraryTraining.CreateTrainingEdition(Training."No.").Edition);
        SalesLine.Validate("Campo 1", 'Valor Campo 1');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [When] Se registra el albarán
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, false);

        // [Then] Los campos personalizados en la línea de albaranes de ventas se han rellenado correctamente
        SalesShipmentLine.Get(DocumentNo, SalesLine."Line No.");
        LibraryAssert.AreEqual(SalesLine."Training No.", SalesShipmentLine."Training No.", 'Nº formación incorrecto');
        LibraryAssert.AreEqual(SalesLine."Training Edition", SalesShipmentLine."Training Edition", 'Edición de formación incorrecta');
        LibraryAssert.AreEqual(Salesline."Campo 1", SalesShipmentLine."Campo 1", 'Campo 1 incorrecto');
        LibraryAssert.AreEqual(0, SalesShipmentLine."Otra cosa", 'Campo Otra cosa incorrecto');
    end;

    [Test]
    procedure CustomFieldsOnResLedgerEntryFillCorrectly()
    var
        Training: Record Training;
        Resource: Record Resource;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ResLedgerEntry: Record "Res. Ledger Entry";
        LibraryTraining: Codeunit "Library - Training";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        DocumentNo: Code[20];
    begin
        // [Scenario] Los campos personalizados en el movimiento de recurso se rellenan correctamente

        // [Given] Una formación
        //          Un recurso vinculado a la formación
        //          Un pedido de venta para un cliente cualquiera
        //          Una línea de venta para el recurso, añadiéndole la edición
        Training := LibraryTraining.CreateTraining();
        Resource := LibraryTraining.CreateResource(Training."No.");
        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);
        SalesLine.Validate(Type, Enum::"Sales Line Type"::Resource);
        SalesLine.Validate("No.", Resource."No.");
        SalesLine.Validate("Training Edition", LibraryTraining.CreateTrainingEdition(Training."No.").Edition);
        SalesLine.Validate("Campo 1", 'Valor Campo 1');
        SalesLine.Validate(Quantity, 1);
        SalesLine.Modify(true);

        // [When] Se registra la factura
        DocumentNo := LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // [Then] Los campos personalizados en el movimiento de recurso se han rellenado correctamente
        ResLedgerEntry.SetRange("Document No.", DocumentNo);
        ResLedgerEntry.SetRange("Entry Type", Enum::"Res. Journal Line Entry Type"::Sale);

        LibraryAssert.AreEqual(1, ResLedgerEntry.Count(), 'No se ha encontrado un único movimiento de recurso');

        ResLedgerEntry.FindFirst();

        LibraryAssert.AreEqual(SalesLine."Training No.", ResLedgerEntry."Training No.", 'Nº formación incorrecto');
        LibraryAssert.AreEqual(SalesLine."Training Edition", ResLedgerEntry."Training Edition", 'Edición de formación incorrecta');
    end;
}