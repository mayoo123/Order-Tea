
Please find path for solution, client manager, fornt end website and database 

Solution - \BubbleTeaBonanza\ClientManager\BubbleTeaBonanza.sln

Client Manager - \BubbleTeaBonanza\ClientManager

Front-End website - \BubbleTeaBonanza\ClientManager\Web Site\Index.aspx

Database - \BubbleTeaBonanza\ClientManager\BubbleTea.mdf


project was run on visual studio 2019 and database BubbleTea.mdf is attached to the Client-Manager project.


Please change the database path on Web site\web.config

<connectionStrings>
    <add name="BubbleTeaConnectionString" connectionString="Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Development\BubbleTeaBonanza\ClientManager\BubbleTea.mdf;Integrated Security=True"
      providerName="System.Data.SqlClient" />
  </connectionStrings>



To run ClientManager - just set client manager as startup project and run on visula studio 
To run Website - just set website as startup project and run on visual studio 


Please let me know if anything not clear and any help to run the project 



