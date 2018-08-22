/**
 * i18n translation file.
 * Data is divided in two languages (Portuguese and English), inside any language it's divided by component (IndexComponent, SidebarComponent, etc).
 */

let messages = {
    en: {
        index: {
            header: 'Calendar'
        },
        sidebar: {
            initial_page: 'Initial page',
            grades: {
                grades: 'Grades',
                provisional: 'Provisional',
                partial: 'Partial',
                final: 'Final',
                definitive: 'Definitive',
                recent: 'Recent',
                grades_log: 'Grades Log'
            },
            assiduity: 'Assiduity',
        },
        assiduity: {
            header: 'Assiduity',
            table: {
                curricular_unit: 'Curricular Unit',
                type: 'Type',
                assiduity: 'Assiduity'
            }
        },
        calendar: {
            today: 'Today',
            month: 'Month',
            week: 'Week',
            day: 'Day',
            list: 'List'
        },
        partial: {
            header: '<b>Provisional</b> partial',
            year: 'Curricular year',
            table: {
                curricular_unit: 'Curricular Unit',
                element: 'Element',
                grade: 'Grade',
            }
        },
        final: {
            header: '<b>Provisional</b> final',
            table: {
                curricular_unit: 'Curricular Unit',
                epoch: 'Epoch',
                final_grade: 'Final Classification',
                write_ex: 'Write Exam',
                oral_ex: 'Oral Exam',
                consultation_date: 'Consultation Date',
                oral_date: 'Oral Date',
                year: 'Curricular year',
                date_registration: 'Registration Date',
                released_by: 'Released by'
            }
        },
        recent: {
            header: '<b>Definitive</b> recent',
            table: {
                curricular_unit: 'Curricular Unit',
                element: 'Element',
                grade: 'Grade',
                course: 'Course',
                release_date: 'Release Date',
                year: 'Curricular year',
                consultation_date: 'Consultation Date',
                oral_date: 'Oral Date',
            }
        },
        definitive: {
            header: '<b>Definitive</b> archive',
            table: {
                curricular_unit: 'Curricular Unit',
                degree: 'Degree',
                grade: 'Grade',
                course: 'Course',
                registration_date: 'Registration Date'
            }
        },
        register: {
            name: 'Name',
            email: 'Email',
            contact: 'Contact',
            number: 'Number',
            password: 'Password',
            register: 'Register',
            update: 'Update',
            remove: 'Remove'
        }
    },
    pt: {
        index: {
            header: 'Calendário'
        },
        sidebar: {
            initial_page: 'Página Inicial',
            grades: {
                grades: 'Notas',
                provisional: 'Provisórias',
                partial: 'Parciais',
                final: 'Finais',
                definitive: 'Definitivas',
                recent: 'Recentes',
                grades_log: 'Arquivo'
            },
            assiduity: 'Assiduity'
        },
        assiduity: {
            header: 'Assiduidade',
            table: {
                curricular_unit: 'Unidade Curricular',
                type: 'Tipo',
                assiduity: 'Assiduidade'
            }
        },
        calendar: {
            today: 'Hoje',
            month: 'Mês',
            week: 'Semana',
            day: 'Dia',
            list: 'Lista'
        },
        partial: {
            header: '<b>Provisórias</b> parciais',
            year: 'Ano curricular',
            table: {
                curricular_unit: 'Unidade Curricular',
                element: 'Elemento',
                grade: 'Nota',
            }
        },
        final: {
            header: '<b>Provisórias</b> finais',
            table: {
                curricular_unit: 'Unidade Curricular',
                epoch: 'Época',
                final_grade: 'Cassificação final',
                write_ex: 'Exame escrito',
                oral_ex: 'Exame oral',
                consultation_date: 'Data da consulta',
                oral_date: 'Data da oral',
                year: 'Ano curricular',
                date_registration: 'Data de registo',
                released_by: 'Lançada por'
            }
        },
        recent: {
            header: '<b>Definitive</b> recent',
            table: {
                curricular_unit: 'Unidade Curricular',
                element: 'Elemento',
                grade: 'Nota',
                course: 'Curso',
                release_date: 'Data de registo',
                year: 'Ano curricular',
                consultation_date: 'Data da consulta',
                oral_date: 'Data da oral',
            }
        },
        definitive: {
            header: '<b>Definitive</b> archive',
            table: {
                curricular_unit: 'Unidade Curricular',
                degree: 'Grau',
                grade: 'Nota',
                course: 'Curso',
                registration_date: 'Data de registo',
            }
        },
        register: {
            name: 'Nome',
            email: 'Email',
            contact: 'Contacto',
            number: 'Número',
            password: 'Password',
            register: 'Registar',
            update: 'Atualizar',
            remove: 'Remover'
        }
    }
};

export default messages;