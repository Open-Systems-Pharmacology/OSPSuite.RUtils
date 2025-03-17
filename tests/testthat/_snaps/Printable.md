# Checks if Printable prints properly

    Code
      x
    Output
      myPrintable: 
         x: NULL 
         y: NULL 

# Checks if Printable subclass cloning works as expected

    Code
      newPrintable1$new()$clone()
    Output
      <newPrintable1>
        Inherits from: <Printable>
        Public:
          clone: function (deep = FALSE) 
        Private:
          printClass: function () 
          printLine: function (entry, value, addTab = TRUE) 

# It prints a line without a value

    Code
      x
    Output
      myPrintable: 
         x: NULL 
         y: 1 
         No value

