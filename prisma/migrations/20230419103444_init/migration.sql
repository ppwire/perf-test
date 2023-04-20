-- CreateTable
CREATE TABLE "Course" (
    "id" TEXT NOT NULL,
    "version" TEXT NOT NULL,

    CONSTRAINT "Course_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CourseRevision" (
    "courseId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "internalNote" TEXT NOT NULL,

    CONSTRAINT "CourseRevision_pkey" PRIMARY KEY ("courseId","revision")
);

-- CreateTable
CREATE TABLE "Part" (
    "id" TEXT NOT NULL,

    CONSTRAINT "Part_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PartRevision" (
    "partId" TEXT NOT NULL,
    "revision" INTEGER NOT NULL,
    "title" TEXT NOT NULL,

    CONSTRAINT "PartRevision_pkey" PRIMARY KEY ("partId","revision")
);

-- CreateTable
CREATE TABLE "CoursePartRelation" (
    "courseId" TEXT NOT NULL,
    "partId" TEXT NOT NULL,
    "courseRevision" INTEGER,
    "partRevision" INTEGER,

    CONSTRAINT "CoursePartRelation_pkey" PRIMARY KEY ("courseId","partId")
);

-- AddForeignKey
ALTER TABLE "CourseRevision" ADD CONSTRAINT "CourseRevision_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "Course"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartRevision" ADD CONSTRAINT "PartRevision_partId_fkey" FOREIGN KEY ("partId") REFERENCES "Part"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_courseId_courseRevision_fkey" FOREIGN KEY ("courseId", "courseRevision") REFERENCES "CourseRevision"("courseId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CoursePartRelation" ADD CONSTRAINT "CoursePartRelation_partId_partRevision_fkey" FOREIGN KEY ("partId", "partRevision") REFERENCES "PartRevision"("partId", "revision") ON DELETE RESTRICT ON UPDATE CASCADE;
