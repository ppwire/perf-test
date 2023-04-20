import { Prisma, PrismaClient } from "@prisma/client";
import { writeFile } from "fs";

const prisma = new PrismaClient();

async function main() {
  const startTime = performance.now();
  const result = await prisma.course.findUnique({
    where: {
      id: "cb97a283-94ec-4eb9-b330-a72a01be6232",
    },
    include: {
      courseVersioneds: {
        orderBy: {
          revision: "desc",
        },
        take: 1,
        include: {
          parts: {
            // orderBy:{
            //   order : "desc"
            // }
            // take: 1,
            include: {
              partVersioned: {
                include: {
                  sections: {
                    include: {
                      sectionVersioned: {
                        include: {
                          subsections: {
                            include: {
                              sectionVersioned: {
                                include: {
                                  subsections: {
                                    include: {
                                      subsectionVersioned: true,
                                    },
                                  },
                                },
                              },
                            },
                          },
                        },
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  });

  console.log(result);

  writeFile("result.json", JSON.stringify(result), (err) => {
    console.log(err);
    process.exit(1);
  });

  const endTime = performance.now();

  console.log("Execute time: " + (endTime - startTime) + "ms");
}

main();
