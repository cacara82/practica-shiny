from shiny import App, ui, render

app_ui = ui.page_fluid( 
    ## TODO
)

def app_server(input, output, session):
    @render.text
    def conversion():
        valor = input.valor()
        return None
    
app = App(app_ui, app_server)