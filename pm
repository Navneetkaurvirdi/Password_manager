import mysql.connector
from tkinter import *
from tkinter import messagebox
import random
import string
from PIL import Image, ImageTk


db = mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = "NAVNEET15",
    database = "passworddb"
)

cursor = db.cursor()

Button
top = Tk()
top.title("PASSWORD MANAGER")
top.geometry("1920x1080")


icon_image = PhotoImage(file="C:\\Users\\nkvir\\OneDrive\\Desktop\\pass.png")
top.iconphoto(False, icon_image)
# ... (previous code)

# Load the second image
image2 = Image.open("C:/Users/nkvir/OneDrive/Desktop/ss.png")
image2 = image2.resize((400, 200))  # Adjust the size as needed
photo2 = ImageTk.PhotoImage(image2)

# Create a Label for the second image and set its position
label2 = Label(top, image=photo2)
label2.image = photo2
label2.place(x=20, y=30)  # Adjust the x and y coordinates to position the second image

# ... (continue with the rest of your code)






background_image = Image.open("C:\\Users\\nkvir\\OneDrive\\Desktop\\s.png")
background_image = background_image.resize((1920, 1080))
background_photo = ImageTk.PhotoImage(background_image)
background_label = Label(top, image=background_photo)
background_label.place(x=0, y=0, relwidth=1, relheight=1)



image2 = Image.open("C:/Users/nkvir/OneDrive/Desktop/ss.png")
image2 = image2.resize((400, 200))  # Adjust the size as needed
photo2 = ImageTk.PhotoImage(image2)

# Create a Label for the second image and set its position
label2 = Label(top, image=photo2)
label2.image = photo2
label2.place(x=550, y=150)  # Adjust the x and y coordinates to position the second image

# ... (continue with the rest of your code)




label = Label(top, text="PASSWORD MANAGER", font=("Helvetica", 40))
label.pack(pady=20)

username_label = Label(top , text = "Username",font=("Helvetica", 16))
username_label.place(x=500, y = 400)
username_entry = Entry(top,font=("Helvetica", 16))
username_entry.place(x = 650, y = 400)

email_label = Label(top , text = "Email",font=("Helvetica", 16))
email_label.place(x = 500 , y = 450)
email_entry = Entry(top,font=("Helvetica", 16))
email_entry.place(x = 650, y = 450)

user_password_label = Label(top , text = "Password",font=("Helvetica", 16))
user_password_label.place(x = 500, y = 500)
user_password_entry = Entry(top , show = "*",font=("Helvetica", 16))
user_password_entry.place(x = 650, y = 500)





def user_window():
    top1 = Toplevel(top)
    top1.geometry("1920x1080")
    #get data
    background_image_top1 = Image.open("C:\\Users\\nkvir\\OneDrive\\Desktop\\new.jpg")
    background_image_top1 = background_image_top1.resize((1000, 900))
    background_photo_top1 = ImageTk.PhotoImage(background_image_top1)
    background_label_top1 = Label(top1, image=background_photo_top1)
    background_label_top1.place(x=0, y=0, relwidth=1, relheight=1)

    username = username_entry.get()
    email = email_entry.get()
    password = user_password_entry.get()
    #welcome label
    welcome_label = Label(top1, text = f"Welcome,{username}!" ,font=("Helvetica", 25), fg="brown")
    welcome_label.place(x=450 , y = 150)

    #add new password
    add_new_password_label = Label(top1, text = "Add new password", font=("Helvetica",18), fg="brown2")
    add_new_password_label.place(x=450 , y = 200)
    #add_website_name
    new_website_label = Label(top1, text = "Website", font=("Helvetica", 16))
    new_website_label.place(x=450, y = 300)
    new_website_entry = Entry(top1,font=("Century Gothic" , 12))
    new_website_entry.place(x=559 , y = 300)
    # #add_new_password
    new_password_label = Label(top1, text = "Password", font=("Helvetica", 16))
    new_password_label.place(x=450 , y=350)
    new_password_entry = Entry(top1 ,font=("Helvetica", 16))
    new_password_entry.place(x=559, y = 350)
    #generate_password_button

    #function to handle the gen password button
    def generate_password():
        password_length = random.randint(10, 16)  # Generates a random length between 10 and 16
        characters = string.ascii_letters + string.digits + string.punctuation
        generated_password = ''.join(random.choice(characters) for i in range(password_length))
        new_password_entry.delete(0, "end")  # Clear any existing text in the entry field
        new_password_entry.insert(0, generated_password)  # Insert the generated password

    #function to handle the add_new_password button
    def add_new_password():
        #get info
        website_name = new_website_entry.get()
        new_password = new_password_entry.get()
        if not(website_name and new_password):
            messagebox.showerror('Error',"Enter complete information")
            return
        
        #get data
    username = username_entry.get()
    email = email_entry.get()
    password = user_password_entry.get()  
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s AND email = %s" ,(username, password , email))
    user_info = cursor.fetchone()  
    if user_info:
        user_id = user_info[0]
        table_name = "user_"+str(user_id)
    else:
        messagebox.showerror('Error', "Some error occured")    
           

    def delpass(table_name):
        website_name = new_website_entry.get()
        cursor.execute("SELECT * FROM {} where website = %s".format(table_name), (website_name,))
        retrieved_password = cursor.fetchone()

        if retrieved_password:
            cursor.execute("DELETE FROM {} WHERE website = %s".format(table_name), (website_name,))
            db.commit()
            messagebox.showinfo("Success", "Password Successfully Deleted!")
        else:
            messagebox.showerror("Error", "Couldn't Delete the Password")




    def repass(table_name):
        cursor.execute("SELECT website, password FROM {}".format(table_name))
        saved_passwords = cursor.fetchall()

        if saved_passwords:
                message = "Saved Passwords:\n"
                for website, password in saved_passwords:
                    message += f"Website: {website}, Password: {password}\n"
        else:
                message = "No saved passwords found."

        messagebox.showinfo("Saved Passwords", message)




     



 ########################## new_password_entry.place(x=559, y = 400)
    #generate_password_button
    generate_password_button = Button(top1, text = "Generate Password", font=("Helvetica", 16), command = generate_password,padx=20, pady=30, fg="NavajoWhite4", bg="NavajoWhite3", activebackground="azure3",relief="raised", borderwidth=4)
    generate_password_button.place(x= 259, y=500)
    #add_password_button
    add_password_button = Button(top1, text = "Add Password", font=("Helvetica", 16), command = add_new_password,padx=20, pady=30, fg="NavajoWhite4", bg="NavajoWhite3", activebackground="azure3",relief="raised", borderwidth=4)
    add_password_button.place(x= 500, y=500) 

    delete_button = Button(top1, text="Delete Password", font=("Helvetica", 16), command=lambda: delpass(table_name), padx=20, pady=30, fg="NavajoWhite4", bg="NavajoWhite3", activebackground="azure3", relief="raised", borderwidth=4)
    delete_button.place(x=689, y=500)

    retrive_button=Button(top1, text=" Retrieve Password", font=("Helvetica", 16),  command=lambda: repass(table_name),padx=20, pady=30, fg="NavajoWhite4", bg="NavajoWhite3", activebackground="azure3",relief="raised", borderwidth=4)
    retrive_button.place(x=900, y=500)

    #showing saved passwords

    top1.mainloop()



def sign_up():
    #get data
    username = username_entry.get()
    email = email_entry.get()
    password = user_password_entry.get()
    if not(username and password and email):
        messagebox.showerror("Error" , "Enter complete information")
        return
    
    #check if user already exists
    cursor.execute("SELECT * FROM users WHERE username = %s AND email = %s" , (username , email))
    existing_user = cursor.fetchone()
    
    if existing_user:
        messagebox.showerror("Error" , "User already exists, Click on 'Already a user'")
        return 
    
    cursor.execute("INSERT INTO users (username , email , password) VALUES (%s , %s , %s)" , (username, email, password))
    db.commit()
    
    #getting the user's id 
    cursor.execute("SELECT LAST_INSERT_ID()")
    user_id = cursor.fetchone()[0]
    
    #creating table with user's id
    table_name = "user_"+ str(user_id)
    cursor.execute(f"CREATE TABLE IF NOT EXISTS {table_name} (id int AUTO_INCREMENT PRIMARY KEY, website VARCHAR(255), password VARCHAR(255))")
    db.commit()
        
    messagebox.showinfo("Success","Account created successfully")
    
    #opening user_Window
    user_window()
    ###################################################################################################3
    

signup_button = Button(top , text = "Create new account" , command = sign_up, padx=50, pady=30, fg="OrangeRed3", bg="azure2", activebackground="azure3", font=("Helvetica", 11), relief="raised", borderwidth=4)
signup_button.place( x = 850 , y = 600)


def log_in():
    
    #get data
    username = username_entry.get()
    email = email_entry.get()
    password = user_password_entry.get()
    #checking if user entered complete information
    if not(username and password):
        messagebox.showerror("Error" , "Enter complete information")
        return
    
    #checking if user exists
    cursor.execute("SELECT * FROM users WHERE username = %s AND password = %s" , (username , password))
    existing_user = cursor.fetchone()
    
    if not existing_user:
        messagebox.showerror("Error", "User doesn't exist!, Click on 'Create new account' ")
        return
    
    messagebox.showinfo("Success", "Logged In Successfully!")
    
    #opening user_window
    user_window()
    

login_button = Button(top , text = "Already a user" , command = log_in, padx=50, pady=30, fg="OrangeRed3", bg="honeydew2", activebackground="azure3", font=("Helvetica", 11), relief="raised", borderwidth=4)
login_button.place( x = 450 , y = 600)


#user_password_entry.place(x = 650, y = 500)

top.mainloop()
