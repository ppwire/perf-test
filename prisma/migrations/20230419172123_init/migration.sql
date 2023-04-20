-- CreateTable
CREATE TABLE "Subsection" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Subsection_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SubsectionVersion" (
    "subsectionId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "SubsectionVersion_pkey" PRIMARY KEY ("subsectionId","revision")
);

-- CreateTable
CREATE TABLE "SectionSubsectionRelation" (
    "sectionId" TEXT NOT NULL,
    "subsectionId" TEXT NOT NULL,
    "sectionRevision" INTEGER NOT NULL,
    "subsectionRevision" INTEGER NOT NULL,

    CONSTRAINT "SectionSubsectionRelation_pkey" PRIMARY KEY ("sectionId","subsectionId","sectionRevision")
);

-- AddForeignKey
ALTER TABLE "SubsectionVersion" ADD CONSTRAINT "SubsectionVersion_subsectionId_fkey" FOREIGN KEY ("subsectionId") REFERENCES "Subsection"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_sectionId_sectionRevision_fkey" FOREIGN KEY ("sectionId", "sectionRevision") REFERENCES "SectionRevision"("sectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SectionSubsectionRelation" ADD CONSTRAINT "SectionSubsectionRelation_subsectionId_subsectionRevision_fkey" FOREIGN KEY ("subsectionId", "subsectionRevision") REFERENCES "SubsectionVersion"("subsectionId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;
