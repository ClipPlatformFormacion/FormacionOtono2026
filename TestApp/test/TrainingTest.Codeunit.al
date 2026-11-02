namespace ClipPlatform.Training.Test;

using ClipPlatform.Training.MasterData;
using ClipPlatform.Training.Setup;
using Microsoft.Projects.Resources.Resource;
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
    begin
        // [Scenario] Cuando se vincula una formación a un recurso, el nombre, precio y bloqueado se copian de la formacion. 
        //            La unidad de medida y grupos contables se copia de la configuración

        // [Given] Una formación con Nombre y Precio
        //          La configuración de la formación con unidad de medida y grupos contables
        //          Un recurso

        Training.Init();
        Training.Insert(true);
        Training.Price := 450;
        Training.Name := 'Una formación de test ' + Training."No.";
        Training.Modify(true);

        Resource.Init();
        Resource.Insert(true);

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
        TrainingLinkedToAnotherResourceErr: TextConst ENU = 'Training %1 is already linked to Resource %2',
                        ESP = 'La formación %1 ya está vinculada con el recurso %2';
    begin
        // [Scenario] No se puede vincular la misma formación a 2 recursos distintos

        // [Given] Una formación
        //         Dos recursos
        //         La formación vinculada al primer recurso
        Training.Init();
        Training.Insert(true);

        Resource1.Init();
        Resource1.Insert(true);
        Resource1.Validate("Training No.", Training."No.");
        Resource1.Modify(true);

        Resource2.Init();
        Resource2.Insert(true);

        // [When] Se vincula la formación al segundo recurso
        asserterror Resource2.Validate("Training No.", Training."No.");

        // [Then] Se tiene que producir un Error
        LibraryAssert.AreEqual(StrSubstNo(TrainingLinkedToAnotherResourceErr, Training."No.", Resource1."No."), GetLastErrorText(), 'El error no es el esperado');
    end;
}