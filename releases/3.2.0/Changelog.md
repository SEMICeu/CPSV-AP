# CPSV-AP Changelog

## Introduction

This document describes the changes to [the current version 3.1.1](https://semiceu.github.io/CPSV-AP/releases/3.1.1/) of the Core Business Vocabulary for which a new version is being proposed ([version 3.2.0](https://semiceu.github.io/CPSV-AP/releases/3.2.0/)). The list of changes results in the new version to be considered as a minor release.

All of the changes were discussed and approved during the [webinar](https://joinup.ec.europa.eu/collection/semic-support-centre/event/webinar-review-core-vocabularies) of 27/10/2023.

## Changes from v3.1.1 to v3.2.0 
The table below gives an overview of the classes (and their definitions) within both data models. Classes that are related are juxta-positioned.

**C** stands for changes in classes

**R** stands for changes in relationships

**P** stands for changes in properties

**D** stands for changes in data types

### Terms
| Nr | CPSCV-AP v3.1.1 | CPAV-AP v3.2.0 | Rationale                                | GitHub/Change                                                                                                                              |
| -- | ------------------------------- | ------------------------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| - | - | ReSpec Styling has been applied to the specification.| - | - |
| C1 | DCAT:Dataset                              | DCAT:Dataset                   | The definition was changed to comply with the autoritativ source. | [#103](https://github.com/SEMICeu/CPSV-AP/issues/103) |
| R1 | CPSV:PublicService.isDescribedAt                              | CPSV:PublicService.isPartOf                   | dct:isPartOf is the inverse relation of dct:hasPart | [#76](https://github.com/SEMICeu/CPSV-AP/issues/76) |
| R2 | CV:ContactPoint.availabilityRestriction         | CV:ContactPoint.availabilityRestriction                   | Additional clarification was provided in the usage note | [#115](https://github.com/SEMICeu/CPSV-AP/issues/115) |
| P1 | CV:Event.type         | CV:BusinessEvent.type                  | The property has been moved to BusinessEvent allowing for the recommendation for the usage of the [Business Event codelist](https://op.europa.eu/en/web/eu-vocabularies/dataset/-/resource?uri=http://publications.europa.eu/resource/dataset/business-event). | [#120](https://github.com/SEMICeu/CPSV-AP/issues/120) |
| P2 | CV:Event.type         | CV:LifesEvent.type                  | The property has been moved to LifeEvent allowing for the recommendation for the usage of the [Life Events codelist](https://op.europa.eu/en/web/eu-vocabularies/dataset/-/resource?uri=http://publications.europa.eu/resource/dataset/life-event). | [#120](https://github.com/SEMICeu/CPSV-AP/issues/120) |

### Additional changes subsequent to the [webinar](https://joinup.ec.europa.eu/collection/semic-support-centre/event/webinar-review-core-vocabularies-and-style-guide-blog-post) of 09/04/2024
The following additional issues were raised during the public review and approved in the [webinar on the review of the Core Vocabularies](https://joinup.ec.europa.eu/collection/semic-support-centre/event/webinar-review-core-vocabularies-and-style-guide-blog-post) which was held on the 9th of April 2024.
| Nr | Draft CPSCV-AP v3.2.0 | CPAV-AP v3.2.0 | Rationale | GitHub / Change |
| --- | --- | --- | --- | --- |
| P3 | - | The range of Administrative Territorial Unit is changed to dct:Location, the usage not with recommendation for ATU is kept.  | Use of specific code list did not align with definition, usage note and Style Guide rule [CMC-R14](https://semiceu.github.io/style-guide/1.0.0/gc-conceptual-model-conventions.html#sec:cmc-r14). | [#123](https://github.com/SEMICeu/CPSV-AP/issues/123) |
| R3 | - |  The optional relationship dct:isPartOf towards dcat:Dataset from cv:Evidence and cv:Ouput is added. | The need to relate cv:Output and cv:Evidence to dcat:Dataset using an optional relation was expressed by the community. Specifically it was requested for a relation for Once Only implementations where evidences and outputs are required to be related to a Dataset. | [#125](https://github.com/SEMICeu/CPSV-AP/issues/125) |
| R3 | - | 1) Explicitly add the “execution” use case to the introduction of the specification and reference the use case in cv:Evidence & cv:Output's usage note. 2) Update language definition to allow description and execution of a Public Service. 3) Update the _relatedDocumentation_ usage note. | 1) How to use cv:Evidence and cv:Output when describing a cpsv:PublicService? 2) Update Language definition to allow both usages of CPSV-AP for the description and execution of Public Services because it does not allow the usage of CPSV-AP in both high-level use cases described below. 3) Update the relatedDocumentation usage note to allow the “execution” use case, making it more generic. | [#128](https://github.com/SEMICeu/CPSV-AP/issues/128) |



