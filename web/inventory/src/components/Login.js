import { useState } from "react";
import Formdata from "./Formdata";
import { createClient } from "@supabase/supabase-js";
import { Navigate } from "react-router-dom";
import "../css/login.css";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "";
const supabase = createClient(supabaseUrl, supabaseKey);

const Login = () => {
  const [successful, setSuccessful] = useState(true);
  const [username, setUsername] = useState("");

  const [login, setLogin] = useState({
    email: "",
    password: "",
  });
  const [pass, setPass] = useState("");
  const handleChange = (event) => {
    const newInput = (data) => ({
      ...data,
      [event.target.name]: event.target.value,
    });
    setLogin(newInput);
  };
  const handleLogin = async (event) => {
    event.preventDefault();

    let { data } = await supabase
      .from("user")
      .select("password, username")
      .eq("email", `${login.email}`);
    setPass(data);

    if (data[0].password === login.password) {
      // window.open("/inventory");
      console.log("successful");
      setUsername(data[0].username);
      console.log(data[0].username);
      toast("Login successful")
      localStorage.setItem("username", JSON.stringify(data[0].username));
      window.location.replace("/home");
      setSuccessful(false);
    } else {
      console.error("wrong email and password");
      toast("Invalid email or password!");
    }
    
  };

  return (
    <>
      <div className="container-login">
        <div className="wrap-login">
          <form action="" method="">
            <span className="login-form-title">Login</span>

            <img
              className="avatar"
              src="https://cdn-icons-png.flaticon.com/512/3135/3135789.png"
              alt=""
              align="center"
            />

            <div className="wrap-input100">
              <input
                className="input100"
                onChange={handleChange}
                value={login.email}
                name="email"
                placeholder="Email"
              />
              <span className="focus-efecto"></span>
            </div>

            <div className="wrap-input100">
              <input
                className="input100"
                type="password"
                onChange={handleChange}
                value={login.password}
                name="password"
                placeholder="Password"
              />
              <span className="focus-efecto"></span>
            </div>

            <div className="container-login-form-btn">
              <div className="wrap-login-form-btn">
                <div className="login-form-bgbtn"></div>
                <button
                  type="submit"
                  name="btnEntrar"
                  className="login-form-btn"
                  onClick={handleLogin}
                >
                  Login
                </button>
                <ToastContainer />
              </div>
              
              <p>New here ? <a href="/register">Register</a></p>
            </div>
          </form>
        </div>
      </div>
    </>
  
  );
};

export default Login;
