/*
  Warnings:

  - The primary key for the `CoursePartRelation` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Made the column `courseRevision` on table `CoursePartRelation` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "CoursePartRelation" DROP CONSTRAINT "CoursePartRelation_pkey",
ALTER COLUMN "courseRevision" SET NOT NULL,
ADD CONSTRAINT "CoursePartRelation_pkey" PRIMARY KEY ("courseId", "partId", "courseRevision");
