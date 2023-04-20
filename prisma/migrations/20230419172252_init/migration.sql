/*
  Warnings:

  - You are about to drop the `SubsectionVersion` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "SectionSubsectionRelation" DROP CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision_fkey";

-- DropForeignKey
ALTER TABLE "SubsectionVersion" DROP CONSTRAINT "SubsectionVersion_subsectionId_fkey";

-- DropTable
DROP TABLE "SubsectionVersion";

-- CreateTable
CREATE TABLE "SubsectionRevision" (
    "subsectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "SubsectionRevision_pkey" PRIMARY KEY ("subsectionId","revision")
);

-- AddForeignKey
ALTER TABLE "SubsectionRevision" ADD CONSTRAINT "SubsectionRevision_subsectionId_fkey" FOREIGN KEY ("subsectionId") REFERENCES "Subsection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision_fkey" FOREIGN KEY ("subsectionId", "subsectionRevision") REFERENCES "SubsectionRevision"("subsectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;
