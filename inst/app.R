#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shinythemes)
library(mousebreedeR)
library(dqrng)
library(dplyr)
library(gtools)
library(ggplot2)
library(reshape2)
library(viridis)
library(ggpubr)
`%!in%` <- Negate(`%in%`)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("slate"),
                # Application title
                titlePanel("mousebreedeR"),

                # Sidebar with a slider input for number of bins
                sidebarLayout(
                  sidebarPanel(
                    h4('Further documentation for this interactive can be found at https://github.com/sportiellomike/mousebreedeR'),
                    h2('Breeder mice upload'),
                    fileInput("file1", "Choose CSV File", accept = ".csv"),
                    h2('Desired genotype'),
                    textInput('desiredvec_shinyinput',"Input your desired vec here with commas, like this using only some combination of homopos,het, or homoneg: homopos,het,homoneg"),
                    h2('Download potential pup table'),
                    downloadButton("downloadData", "Download potential pup table"),
                    # selectInput("species", "species",
                    #             c('Mouse'='Mmu',
                    #               'Human'='Hsa')),
                    # selectInput('geneformat','Gene format',
                    #             c('Symbol','ENTREZID')),
                    # selectInput('inputformat','Input format',
                    #             c('Dataframe')),
                    # selectInput("padjcolname", "Column to use for P value adjustment",''),
                    # selectInput("LFCcolname", "Column with adjusted Log Fold Change values. Note that LFC col name must be log2FoldChange.",''),
                    # numericInput("pcutoff", "Significance cutoff (alpha)", 0.05, min = 0, max = 1),
                    # downloadButton("downloadData", "Download output table"),
                    # h1('This interactive supports dataframe inputs to fluximplied only.')
                  ),

                  #create the main panel plotting and printing outputs
                  mainPanel(
                    # h2("Output table"),
                    # tableOutput(outputId = 'table'),
                    # h2("Plot"),
                    # plotOutput(outputId = 'plot'),

                    h2("Breeder Mice"),
                    h4("This is the CSV you supplied to us. Make sure the column on the right is 'sex' and the columns to the left are your gene columns. There should not be a separate column for row names in your CSV."),
                    h4(dataTableOutput(outputId = 'suppliedCSV')),

                    h2("Desiredvec"),
                    h4('This is the desiredvec you entered to the left. Make sure the only values here are homopos, homoneg, or het separated by commas. Each gene in your supplied csv should have a desired geneotype at each locus (for example, 3 gene columns should have 3 entries to the left separated by commas).'),
                    verbatimTextOutput("desiredvec_processed"),

                    h2("Number of crosses required"),
                    # h4('this is can_we_get_all_the_alleles_from_one_cross_shiny'),
                    verbatimTextOutput('can_we_get_all_the_alleles_from_one_cross_shiny'),

                    h2("Which mice should be paired?"),
                    # h4('this is points which pairs to breed'),
                    verbatimTextOutput(outputId = 'whichpairstobreed_shinyoutput'),

                    h2("Potential pups"),
                    # h4("Summarize potential pup output"),
                    h4(dataTableOutput(outputId = "summarize_potential_pup_output")),

                    h2("Fertilization summary"),
                    h4("Distribution per gene per cross."),
                    h4(dataTableOutput(outputId = "summarize_fertilization_output"))



                  )
                )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$desiredvec_processed<-renderPrint({
    x <- unlist(strsplit(input$desiredvec_shinyinput,","))
    # cat("As atomic vector:\n")
    print(x)
  }
  )

  output$suppliedCSV <-renderDataTable({
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
    # print(df)
  }
  )


  output$summarize_fertilization_output <-renderDataTable({
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
# print(df)

    meiosis_output<-engage_in_meiosis(df)
    compile_gametes_output<-compile_gametes(meiosis_output)
    sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
    fertilize_output<-fertilize(malegametes = sperm,
                                femalegametes = eggs)
    summarize_fertilization_shinyoutput<-summarize_fertilization(fertilize_output)
    # colnames(summarize_fertilization_shinyoutput)
    colindex_fertshiny<-which(colnames(summarize_fertilization_shinyoutput) %in% c(
      "percenthomoneg",
      "percenthet",
      "percenthomopos",
      "gene",
      # "mom",
      # "dad",
      "momdad"
    ))
    summarize_fertilization_shinyoutput<-summarize_fertilization_shinyoutput[,colindex_fertshiny]
    colnames(summarize_fertilization_shinyoutput)<-c('Percent HomoNeg','Percent Het','Percent HomoPos','Gene','Mom_x_Dad')

    # momdad_split<-function(MomDadColTosplit){
    #   strsplit(x = MomDadColTosplit,split = "x",)
    # }
    # sapply(summarize_fertilization_shinyoutput$Mom_x_Dad,FUN = momdad_split)[1]
    #
    #
    # unlist(lapply(strsplit(as.character(summarize_fertilization_shinyoutput$Mom_x_Dad), "&auty="), '[[', 1))

    # sub("x.*", "", summarize_fertilization_shinyoutput$Mom_x_Dad)
    summarize_fertilization_shinyoutput$Mom<-vapply(strsplit(summarize_fertilization_shinyoutput$Mom_x_Dad, "x", fixed = F), "[", "", 1)
    summarize_fertilization_shinyoutput$Dad<-vapply(strsplit(summarize_fertilization_shinyoutput$Mom_x_Dad, "x", fixed = F), "[", "", 2)
    summarize_fertilization_shinyoutput
  })



  output$summarize_potential_pup_output <-renderDataTable({
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
    # print(df)

    meiosis_output<-engage_in_meiosis(df)
    compile_gametes_output<-compile_gametes(meiosis_output)
    sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
    fertilize_output<-fertilize(malegametes = sperm,
                                femalegametes = eggs)
    summarize_potential_pup_output<-summarize_potential_pups(fertilize_output)
    colindex_summarize_potential_pup_output_shiny<-which(colnames(summarize_potential_pup_output) %in% c(
      "momdad",
      # "freqchanceonepup",
      "percentchanceonepup"
    ))
    genecolnames<-colnames(Filter(function(x) any(x %in% c('homoneg','het','homopos')), summarize_potential_pup_output))
    genecolnames_index<- which(colnames(summarize_potential_pup_output) %in% genecolnames)
    colindex_summarize_potential_pup_output_shiny_complete<-c(genecolnames_index,colindex_summarize_potential_pup_output_shiny)
    summarize_potential_pup_output<-summarize_potential_pup_output[,colindex_summarize_potential_pup_output_shiny_complete]
    colnames(summarize_potential_pup_output)[colnames(summarize_potential_pup_output) %in% c(
      "momdad",
      # "freqchanceonepup",
      "percentchanceonepup"
    )]<-c(
      'Mom_x_Dad',
      'Percent chance to get a pup with genotype'
    )
    # summarize_potential_pup_output$`Percent chance to not get desired genotype for a litter of 5`<-100*summarize_potential_pup_output$`Percent chance to not get desired genotype for a litter of 5`
    summarize_potential_pup_output
  })


  tabledownload <- reactive({
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
    # print(df)

    meiosis_output<-engage_in_meiosis(df)
    compile_gametes_output<-compile_gametes(meiosis_output)
    sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
    fertilize_output<-fertilize(malegametes = sperm,
                                femalegametes = eggs)
    summarize_potential_pup_output<-summarize_potential_pups(fertilize_output)
    colindex_summarize_potential_pup_output_shiny<-which(colnames(summarize_potential_pup_output) %in% c(
      "momdad",
      # "freqchanceonepup",
      "percentchanceonepup"
    ))
    genecolnames<-colnames(Filter(function(x) any(x %in% c('homoneg','het','homopos')), summarize_potential_pup_output))
    genecolnames_index<- which(colnames(summarize_potential_pup_output) %in% genecolnames)
    colindex_summarize_potential_pup_output_shiny_complete<-c(genecolnames_index,colindex_summarize_potential_pup_output_shiny)
    summarize_potential_pup_output<-summarize_potential_pup_output[,colindex_summarize_potential_pup_output_shiny_complete]
    colnames(summarize_potential_pup_output)[colnames(summarize_potential_pup_output) %in% c(
      "momdad",
      # "freqchanceonepup",
      "percentchanceonepup"
    )]<-c(
      'Mom_x_Dad',
      'Percent chance to get a pup with genotype'
    )
    # summarize_potential_pup_output$`Percent chance to not get desired genotype for a litter of 5`<-100*summarize_potential_pup_output$`Percent chance to not get desired genotype for a litter of 5`
    summarize_potential_pup_output
  })

  output$tabledownload <- renderTable({

    tabledownload()
  })

  output$downloadData  <- downloadHandler(
    filename = function() {
      paste('PotentialPupTable', ".csv", sep = "")
    },
    content = function(file) {
      write.csv(tabledownload(), file, row.names = T)
    }
  )



  output$can_we_get_all_the_alleles_from_one_cross_shiny <-renderPrint({
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
    # print(df)

    meiosis_output<-engage_in_meiosis(df)
    compile_gametes_output<-compile_gametes(meiosis_output)
    sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
    fertilize_output<-fertilize(malegametes = sperm,
                                femalegametes = eggs)

    desiredvec<- unlist(strsplit(input$desiredvec_shinyinput,","))
    # cat("As atomic vector:\n")
    # print(x)

    can_we_get_all_the_alleles_from_one_cross(x = fertilize_output,desiredvector = desiredvec)
  })


  # output$whichpairstobreed_shinyoutput <-renderPrint({
  #   desiredvec <<- unlist(strsplit(input$desiredvec_shinyinput,","))
  #   inFile <- input$file1
  #   df <- read.csv(inFile$datapath, header = T)
  #   # print(df)
  #   desiredvec_whichpairstobreed_shinyoutput <- unlist(strsplit(input$desiredvec_shinyinput,","))
  #
  #   meiosis_output<-engage_in_meiosis(df)
  #   compile_gametes_output<-compile_gametes(meiosis_output)
  #   sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
  #   fertilize_output<-fertilize(malegametes = sperm,
  #                               femalegametes = eggs)
  #   summarize_potential_pup_output<-summarize_potential_pups(fertilize_output)
  #   pointsperpupoutput<-points_per_pup(x = summarize_potential_pup_output,desiredvector = desiredvec_whichpairstobreed_shinyoutput)
  #   which_pairs_should_i_breed_output<- which_pairs_should_i_breed(x=pointsperpupoutput,desiredvector = desiredvec_whichpairstobreed_shinyoutput)
  #   # return(which_pairs_should_i_breed_output)
  # })

  output$whichpairstobreed_shinyoutput<- renderPrint({
    desiredvec<-unlist(strsplit(input$desiredvec_shinyinput,","))
    inFile <- input$file1
    df <- read.csv(inFile$datapath, header = T)
    meiosis_output<-engage_in_meiosis(x = df)
    compile_gametes_output<-compile_gametes(x = meiosis_output)
    sperm_and_eggs(x = compile_gametes_output,sex = 'sex')
    fertilize_output<-fertilize(malegametes = sperm,femalegametes = eggs)
    summarize_potential_pup_output<-summarize_potential_pups(x = fertilize_output)
    pointsperpupoutput<-points_per_pup(summarize_potential_pup_output,desiredvector = desiredvec)
    which_pairs_should_i_breed_output<-which_pairs_should_i_breed(pointsperpupoutput,desiredvector = desiredvec)
    which_pairs_should_i_breed_output

  })




}

# Run the application
shinyApp(ui = ui, server = server)
