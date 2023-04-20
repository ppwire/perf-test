/*
  Warnings:

  - Made the column `partRevision` on table `CoursePartRelation` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "CoursePartRelation" ALTER COLUMN "partRevision" SET NOT NULL;

-- CreateTable
CREATE TABLE "Section" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SectionRevision" (
    "sectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "SectionRevision_pkey" PRIMARY KEY ("sectionId","revision")
);

-- CreateTable
CREATE TABLE "PartSectionRelation" (
    "partId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "partRevision" INTEGER NOT NULL,
    "sectionRevision" INTEGER NOT NULL,

    CONSTRAINT "PartSectionRelation_pkey" PRIMARY KEY ("partId","sectionId","partRevision")
);

-- AddForeignKey
ALTER TABLE "SectionRevision" ADD CONSTRAINT "SectionRevision_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_partId_partRevision_fkey" FOREIGN KEY ("partId", "partRevision") REFERENCES "PartRevision"("partId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartSectionRelation" ADD CONSTRAINT "PartSectionRelation_sectionId_sectionRevision_fkey" FOREIGN KEY ("sectionId", "sectionRevision") REFERENCES "SectionRevision"("sectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;
