import { useState } from "react";
import Formdata from "./Formdata";
import { createClient } from "@supabase/supabase-js";
import { Navigate } from "react-router-dom";
import "../css/login.css";

const supabaseUrl = "https://jzhlkcwolnaereowofhu.supabase.co";
const supabaseKey =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp6aGxrY3dvbG5hZXJlb3dvZmh1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODAwOTk2NzgsImV4cCI6MTk5NTY3NTY3OH0.LyyqZm5NOyK8oRkLqMpzggpEExpX5z-nyyDWgRsaAk4";
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
      localStorage.setItem("username", JSON.stringify(data[0].username));
      window.location.replace("/inventory");
      setSuccessful(false);
    } else {
      console.error("wrong email and password");
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
                type="text"
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
              </div>
              
              <p>New here ? <a href="/register">Register</a></p>
            </div>
          </form>
        </div>
      </div>
    </>
    // <>
    //   <div classNameName="col">
    //     <input
    //       type="text"
    //       onChange={handleChange}
    //       value={login.email}
    //       name="email"
    //       classNameName="form-control"
    //       placeholder="Email"
    //     ></input>
    //   </div>
    //   <div classNameName="col">
    //     <input
    // type="text"
    // onChange={handleChange}
    // value={login.password}
    // name="password"
    // classNameName="form-control"
    // placeholder="Password"
    //     ></input>
    //   </div>
    //   <div classNameName="col">
    //     <input
    // type="submit"
    // onClick={handleLogin}
    // classNameName="btn btn-primary"
    //     ></input>
    //   </div>
    // </>
  );
};

export default Login;
