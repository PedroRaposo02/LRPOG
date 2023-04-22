/*
Suponha que a seguinte lista telefónica geral dos docentes do IPP é disponibilizada electronicamente:

<nome escola><num alunos><endereço>

<nome docente><ext><departamento>

…..

<nome escola><num alunos><endereço>

<nome docente><ext><departamento>

…..

O formato de cada campo é o seguinte:

<nome escola>só aceita os valores ISEP, ISCAP, ESE

<num alunos>inteiro maior que 100

<endereço>string com um máximo de 40 caracteres limitada por aspas (pode incluir espaços)

<nome docente>string com um máximo de 40 caracteres limitada por aspas (pode incluir espaços)

<ext>inteiro maior que 999

<departamento>string com um máximo de 40 caracteres limitada por aspas (pode incluir espaços)

Considere que o universo do IPP é constituído pelas seguintes escolas: ISEP, ISCAP, ESE e que cada escola tem pelo menos um docente na lista telefónica

a)Defina a gramática que reconheça a lista telefónica (definida em cima)

b)Implemente a gramática utilizando o Flex e o Bison. Para além da validação do ficheiro o programa deve produzir os seguintes dados de saída:

1.Nome da escola com mais alunos

2.Nome e extensão dos docentes do departamento de “Engª Informática” do ISEP
*/


%{

    #include <stdlib.h>
    #include <stdio.h>
    #include <string.h>

    #define NUMBER_OF_SCHOOLS 3
    #define MAX_SCHOOL_NAME 5
    #define MAX_TEACHER_NAME 43
    #define MAX_SCHOOL_ADDRESS 43
    #define MAX_DEPARTMENT_NAME 43
    #define MAX_LENGHT 255

    int schoolCount = 0;

    struct Teacher {
        char name[MAX_TEACHER_NAME];
        int ext;
        char department[MAX_DEPARTMENT_NAME];
    };

    struct School {
        char name[MAX_SCHOOL_NAME];
        int numStudents;
        char address[MAX_SCHOOL_ADDRESS];
        struct Teacher* teachers;
        int numTeachers;
    };

    struct School schools[3];

    struct School* schoolWithMostStudents = NULL;
    struct Teacher* isepSoftwareTeachers = NULL;
    size_t isepSoftwareTeachersCount = 0;
%}



DIGIT [0-9]
QUOTE ["]

SCHOOL_NAME (ISEP)|(ISCAP)|(ESE)

NUM_STUDENTS ([1-9]{DIGIT}{2,})
ADDRESS ({QUOTE}[^"]{1,40}{QUOTE})
TEACHER_NAME ({QUOTE}[^"]{1,40}{QUOTE})
EXT ([1-9][0-9]{3,})
DEPARTMENT ({QUOTE}[^"]{1,40}{QUOTE})
BLANKS [ \t]*

TEACHER {BLANKS}{TEACHER_NAME}{BLANKS}{EXT}{BLANKS}{DEPARTMENT}{BLANKS}
SCHOOL_LINE ({BLANKS}{SCHOOL_NAME}{BLANKS}{NUM_STUDENTS}{BLANKS}{ADDRESS}{BLANKS}\n)({TEACHER}(\n)?)*


%%

{SCHOOL_LINE} {

    char* tmp = yytext;
    // get first line
    char* line = strtok(tmp, "\n");
    size_t lineSize = strlen(line);
    // get school name
    char* schoolName = strtok(line, " \t");
    // get school num students
    int schoolNumStudents = atoi(strtok(NULL, " \t"));
    // get school address inside the quotes
    char* schoolAddress = strtok(NULL, "\"");
    if(schoolWithMostStudents == NULL) {
        schoolWithMostStudents = &schools[schoolCount];
    } 
    else if (schoolNumStudents > schoolWithMostStudents->numStudents) {
        schoolWithMostStudents = &schools[schoolCount];
    }

    strcpy(schools[schoolCount].name, schoolName);
    schools[schoolCount].numStudents = schoolNumStudents;
    strcpy(schools[schoolCount].address, schoolAddress);

    // get teachers
    tmp += lineSize + 1;
    line = strtok(tmp, "\n");
    while (line != NULL) {

        lineSize = strlen(line);

        char* teacherName = strtok(line, "\"");
        int teacherExt = atoi(strtok(NULL, " \t"));
        char* teacherDepartment = strtok(NULL, "\"");

        schools[schoolCount].numTeachers++;
        if(schools[schoolCount].teachers == NULL) {
            schools[schoolCount].teachers = (struct Teacher*) malloc(sizeof(struct Teacher));
        }
        else {
            schools[schoolCount].teachers = (struct Teacher*) realloc(schools[schoolCount].teachers, sizeof(struct Teacher) * (schools[schoolCount].numTeachers));
        }

        if(strcmp(schoolName, "ISEP") == 0 && strcmp(teacherDepartment, "Engª Informática") == 0) {
            if(isepSoftwareTeachers == NULL) {
                isepSoftwareTeachers = (struct Teacher*) malloc(sizeof(struct Teacher));
            }
            else {
                isepSoftwareTeachers = (struct Teacher*) realloc(isepSoftwareTeachers, sizeof(struct Teacher) * (isepSoftwareTeachersCount + 1));
            }


            strcpy(isepSoftwareTeachers[isepSoftwareTeachersCount].name, teacherName);
            isepSoftwareTeachers[isepSoftwareTeachersCount].ext = teacherExt;
            strcpy(isepSoftwareTeachers[isepSoftwareTeachersCount].department, teacherDepartment);

            isepSoftwareTeachersCount++;
        }

        tmp += lineSize + 1;
        line = strtok(tmp, "\n");
    }

    schoolCount++;
    
}

.* {
    printf("Ignored: %s\n", yytext);
}

%%

int main() {
    yylex();
    // print school with most students
    printf("Escola com mais alunos: %s\n\n", schoolWithMostStudents->name);
    // print isep software teachers
    printf("Docentes de Engª Informática do ISEP:\n");
    for(int i = 0; i < isepSoftwareTeachersCount; i++) {
        printf("Docente %d:\n", i + 1);
        printf("    Nome: %s\n", isepSoftwareTeachers[i].name);
        printf("    Ext: %d\n", isepSoftwareTeachers[i].ext);
    }

    return 0;
}