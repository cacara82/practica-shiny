# IMPORT LIBRARIES

# install.packages("shiny")
library(shiny)

# UI ATTRIBUTE DEFINITION

ui <- fluidPage(
  titlePanel("Visor d'Arxius CSV Senzill 📂"), # App title
  sidebarLayout( # Control sidebar
    sidebarPanel(
      fileInput("archivo_csv", "Puja el teu arxiu CSV:", accept = c("text/csv","text/comma-separated-values,text/plain",".csv")), # CSV Uploader
      tags$hr(), # Horizontal separator line
      p("*Nota: Assegura't de que el teu arxiu tingui headings per les columnes.") # <p> HTML tag
    ),
    mainPanel( # Main panel of the page for CSV table output
      tableOutput("contenido_csv")
    )
  )
)

# SERVER ATTRIBUTE DEFINITION

server <- function(input, output) {
  datos_cargados <- reactive({ # Reactive function: reads CSV input dinamically
    req(input$archivo_csv) # Requires the CSV file attribute exists as a validation
    tryCatch(  # Tries to read the CSV
      {
        df <- read.csv(input$archivo_csv$datapath,
                       header = TRUE, # Assumes headers exist
                       stringsAsFactors = FALSE) # Reads strings as chars
        return(df) # Returns the DF
      },
      error = function(e) { # Returns NULL if error reading file
        print(paste("Error llegint l'arxiu CSV:", e))
        return(NULL)
      }
    )
  })
  
  output$contenido_csv <- renderTable({  # Function to show the results in a table
    if (!is.null(datos_cargados()) && nrow(datos_cargados()) > 0) { # ONLY shows the table if datos_cargados() is not NULL and has got data
      head(datos_cargados(), n = 10) # Shows the first 10 rows
    } else {
      data.frame(Mensaje = "Error: puja un arxiu CSV vàlid per poder veure les dades correctament.") # If no data, shows an error message
    }
  })
}

# EXECUTION AND DEPLOYMENT OF THE APP

shinyApp(ui = ui, server = server)
