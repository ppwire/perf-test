import { Prisma, PrismaClient, SectionRevision } from "@prisma/client";
import { randomUUID } from "crypto";

const prisma = new PrismaClient();

async function main() {
  const startTime = performance.now();

  await prisma.coursePartRelation.deleteMany();
  await prisma.partSectionRelation.deleteMany();
  await prisma.sectionSubsectionRelation.deleteMany();
  // await prisma.courseMasterRecordRelation.deleteMany();
  // await prisma.courseBin.deleteMany();
  // await prisma.courseAsset.deleteMany();
  await prisma.subsectionRevision.deleteMany();
  await prisma.subsection.deleteMany();
  await prisma.sectionRevision.deleteMany();
  await prisma.section.deleteMany();
  await prisma.partRevision.deleteMany();
  await prisma.part.deleteMany();
  await prisma.courseRevision.deleteMany();
  await prisma.course.deleteMany();

  const courseAmount = 700;
  const courseRevisionAmount = 50;

  const partAmount = 10;
  const partRevisionAmount = 50;

  const sectionAmount = 20;
  const sectionRevisionAmount = 30;

  // const subsectionAmount = 20;
  // const subsectionRevisionAmount = 20;

  //Actual amount of parts
  const partActual = partAmount * courseAmount * courseRevisionAmount;
  // 10*700*50 = 350000
  const sectionActual = sectionAmount * partActual * partRevisionAmount;
  // 20*350000*50 = 70000000
  // const subsectionActual =
  //   subsectionAmount * sectionActual * sectionRevisionAmount;

  const partResult = [];
  const courseResult = [];
  const sectionResult = [];
  // const subsectionResult = [];

  // for (let index = 0; index < subsectionActual; index++) {
  //   const subsectionId = randomUUID();
  //   const revision: Prisma.SubsectionRevisionCreateWithoutSubsectionInput[] =
  //     [];

  //   for (let i = 0; i < subsectionRevisionAmount; i++) {
  //     revision.push({
  //       title: `Subsection Title revision ${i + 1}`,
  //       revision: i + 1,
  //     });
  //   }

  //   const result = await prisma.subsection.create({
  //     data: {
  //       id: subsectionId,
  //       subsectionVersioneds: {
  //         createMany: {
  //           data: revision,
  //         },
  //       },
  //     },
  //     include: {
  //       subsectionVersioneds: true,
  //     },
  //   });

  //   subsectionResult.push(result);
  // }

  const section: Prisma.SectionCreateManyInput[] = [];
  const sectionRevision: Prisma.SectionRevisionCreateManyInput[] = [];

  for (let index = 0; index < sectionActual; index++) {
    const sectionId = randomUUID();

    for (let i = 0; i < sectionRevisionAmount; i++) {
      sectionRevision.push({
        title: `Section Title revision ${i + 1}`,
        revision: i + 1,
        sectionId: sectionId,
      });
    }

    sectionResult.push({
      id: sectionId,
      sectionVersioneds: sectionRevision,
    });
  }

  await prisma.section.createMany({
    data: section,
  });

  await prisma.sectionRevision.createMany({
    data: sectionRevision,
  });

  const part: Prisma.PartCreateManyInput[] = [];
  const partRevision: Prisma.PartRevisionCreateManyInput[] = [];

  for (let index = 0; index < partActual; index++) {
    const partId = randomUUID();

    for (let i = 0; i < partRevisionAmount; i++) {
      partRevision.push({
        title: `Part Title revision ${i + 1}`,
        revision: i + 1,
        partId: partId,
      });
    }

    partResult.push({
      id: partId,
      partVersioneds: partRevision,
    });
  }

  await prisma.part.createMany({
    data: part,
  });

  await prisma.partRevision.createMany({
    data: partRevision,
  });

  const course: Prisma.CourseCreateManyInput[] = [];
  const courseRevision: Prisma.CourseRevisionCreateManyInput[] = [];

  for (let index = 0; index < courseAmount; index++) {
    const courseId = randomUUID();
    for (let i = 0; i < courseRevisionAmount; i++) {
      courseRevision.push({
        internalNote: "Internal Note",
        revision: i + 1,
        courseId: courseId,
      });
    }

    courseResult.push({
      id: courseId,
      courseVersioneds: courseRevision,
    });
  }

  await prisma.course.createMany({
    data: course,
  });

  await prisma.courseRevision.createMany({
    data: courseRevision,
  });

  const coursePartRelation: Prisma.CoursePartRelationCreateManyInput[] = [];

  let start = 0;
  for (const course of courseResult) {
    for (const courseVersion of course.courseVersioneds) {
      for (let p = start; p < start + partAmount; p++) {
        const max = partResult[p].partVersioneds.length - 1;
        coursePartRelation.push({
          courseId: course.id,
          courseRevision: courseVersion.revision,
          partId: partResult[p].id,
          partRevision: partResult[p].partVersioneds[max].revision,
        });
      }
    }
    start += partAmount;
  }

  await prisma.coursePartRelation.createMany({
    data: coursePartRelation,
  });

  const partSectionRelation: Prisma.PartSectionRelationCreateManyInput[] = [];

  let sectionStart = 0;
  for (const part of partResult) {
    for (const partVersion of part.partVersioneds) {
      for (let s = sectionStart; s < sectionStart + sectionAmount; s++) {
        const max = sectionResult[s].sectionVersioneds.length - 1;
        partSectionRelation.push({
          partId: part.id,
          partRevision: partVersion.revision,
          sectionId: sectionResult[s].id,
          sectionRevision: sectionResult[s].sectionVersioneds[max].revision,
        });
      }
    }
    sectionStart += sectionAmount;
  }

  await prisma.partSectionRelation.createMany({
    data: partSectionRelation,
  });

  // const sectionSubsectionRelation: Prisma.SectionSubsectionRelationCreateManyInput[] =
  //   [];

  // let subsectionStart = 0;
  // for (const section of sectionResult) {
  //   for (const sectionVersion of section.sectionVersioneds) {
  //     for (
  //       let s = subsectionStart;
  //       s < subsectionStart + subsectionAmount;
  //       s++
  //     ) {
  //       const max = subsectionResult[s].subsectionVersioneds.length - 1;

  //       sectionSubsectionRelation.push({
  //         sectionId: section.id,
  //         sectionRevision: sectionVersion.revision,
  //         subsectionId: subsectionResult[s].id,
  //         subsectionRevision:
  //           subsectionResult[s].subsectionVersioneds[max].revision,
  //       });
  //     }
  //   }
  //   subsectionStart += subsectionAmount;
  // }

  // await prisma.sectionSubsectionRelation.createMany({
  //   data: sectionSubsectionRelation,
  // });

  const endTime = performance.now();
  console.log("Execute time: " + (endTime - startTime) + "ms");
}

main()
  .catch((e) => console.error(e))
  .finally(async () => {
    await prisma.$disconnect();
  });
