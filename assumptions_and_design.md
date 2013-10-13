## assumptions and design

I assume the basic input is the content of **Order**. And there is an **OrderParser** in my design which concentrates on parsing the inputed stirng to order. Detailed， the OrderParser parse order through analysising quantity, price, product name and whether imported. And then create corresponding **Product**, **Item** and **Order**.

To make the parser work, I added a config file *product_type.rb* in config directory. If the application is used without parser, the config file also be unnecessary exsit here.

And I assume the basic ouput is the content of **Receipt**. The receipt is produced by calling order's check_out. It has the list of purchased product's detail which include product name, quantity and payment amount,  total taxs and total payment amount.

As I have said, There also be Product, Item and Order. The **Product** is just a plain object which represent product in real world. **Item** just represent one row record in order. And the **Order** just represent order in real world, which naturally comprise of some items. In my design, I calculate this time purchased product's total tax and total payment amount in Order. The difference of order's item and receipt's item is the former contain product's shelf price the latter contain product's payment amount.

Last but not least, I designed a file called  *sales_tax_policy.rb*. It holds all the potential change of sales tax policy. As I assume, the policy of sales tax may have some change such as change basic sales tax rate, imported sales tax rate, the exempt product type and even the calculation way of product's sales taxs. In my early design, the function of calculate sales tax is placed in product. Then I though the **StalesTaxPolicy** may be a better place fo that function. One reason is that separate stable part and changeable part. Another reasion is making Product concentrate on the function of itself. In a sense, this design follow the  **Single Responsibility Principle**. To follow Global consistency I let the SalesTaxPolicy be an eigen class. And this design use **Singleton patten** unconsciously.
