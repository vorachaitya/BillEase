<h1 align="center">
  <a href="https://github.com/vorachaitya/BillEase">
    <img src="https://user-images.githubusercontent.com/90527884/229326899-5ed8c147-5a63-4816-ae9f-4fbfae8b58c3.png" alt="BillEase" width="300" height="250">
  </a>
  <br>
</h1>
<div align="center">
  KJSCE 7.0 hack || Team AutoBots
</div>

### 🤔 Problem Statement
Whenever we pay bills at shop, we get a bill's paper receipt which although is short in length but eventually when put together globally results in huge amount of paper loss.Also, we usually tend to throw away the bill receipts as it is difficult to file them, thereby refraining us to refer past bill details in future.

At times, it becomes difficult for shop owner to keep a track of his current available stock manually.There are chances of the bills being tampered by third party as well.

### 🚀 Solution
Thus, we have developed ***BillEase***, a system wherein hardcopy of bills, i.e, paper bills are not generated at any point of time thereby making it environment friendly to save trees.

To make life of shop owner further easier, we have developed an inventory management portal for them wherein they can keep track of their product stock easily.Now, the entire bill generation and payment system will be carried out smoothly. Entire process can be further understood as shown below:

### 😊 Flowchart
<img src="https://user-images.githubusercontent.com/90527884/229328914-dbceac19-8f44-4416-b107-198958bb4e7c.jpeg" alt="BillEase" width="1000" height="550">

### ✨Features
BillEase is splitted into parts: **web app** and **mobile app**. It has two access levels - **shop owner** and **customer**.
- ***Web Application***
  - Used by shop owners to access inventory management.
  - Supports addition of product, details, price, quantity to database
  - Barcode is generated and assigned to each newly added product 
  - Updation and deletion of products from inventory
  - Overall items of inventory are displayed and an excel sheet is generated
- ***Mobile Application***
This has two access levels:
 1. **Shop owner**
    - Uploads an excel sheet containing details of products present in inventory
    - Scans barcode of products purchased by customer and generates a bill(pdf format)
    - To ensure security and authorization, bill is stored on **IPFS** (Inter-Planetary File System) where it becomes immutable and cannot be tampered by third-party       - QR-code for bill payment is generated which is sent to respective customer
    - Updates inventory after selling of products
    - View line chart depicting customers with their purchase ranges in order to have better understanding of customer choices and make plans to increase thier sales accordingly
 2. **Customer**
    - Buys products whose barcodes are scanned by owner and bill is sent to them
    - Can either pay in cash or UPI
    - Recieves QR-code for payment for UPI payment
    - Can access his/her bill history for future use
    - View line chart depicting bill amount with thier dates in order to analyse thier expenditure and take necessary actions
    
###  🤖Resources
- [Demo Video](https://www.youtube.com/watch?v=wKIEDrzpnWc)
- [GitHub Repository](https://github.com/vorachaitya/BillEase)
- [Devfolio Submission](https://devfolio.co/projects/billease-e55b)
- [APK Link](https://drive.google.com/file/d/1XgVvhZkxsS2Gm3Ulwy4ZCLStOMZk5lpb/view?usp=drivesdk)

### ⚙️ Tech Stack
1. **Web Development**
- Frontend : React.js ,TailwindCSS ,Bootstrap
- Backend : Firebase
2. **App Development**
- Frontend :Flutter, Dart
- Backend : Firebase

### 🔍 Future Scope!
- Reward customer with scratch cards for each payment done
- Payment via modes like debit/credit cards, internet banking
- Track user behaviour and predict about their future purchases

### 👨‍💻 Team Members
- [Harshil Shah](https://github.com/harshilshah99)
- [Ananya Bangera](https://github.com/ananya-bangera)
- [Tushar Mali](https://github.com/7-USH)
- [Chaitya Vora](https://github.com/vorachaitya)
