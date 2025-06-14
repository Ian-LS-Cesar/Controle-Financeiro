import React, { useState } from 'react'
import { useNavigate } from "react-router-dom";
import { FaUser, FaLock } from "react-icons/fa";
import "./Cadastro.css";

const Cadastro = () => {
  const navigate = useNavigate();
  const [name, setName] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleCadastro = async (event) => {
    event.preventDefault();
    alert("enviando dados:" + name + username + password);
    navigate("/Login");
  }

  return (
    <div className='container'>  
      <form onSubmit={handleCadastro}> 
        <h1> Cadastro </h1>
        <div className='input-field'> 
          <input type="text" placeholder='Nome'
            required
            onChange={(e) => setName(e.target.value)}/>
          <FaUser className="icon"/>
        </div>
        <div className='input-field'> 
          <input type="email" placeholder='Email'
            required
            onChange={(e) => setUsername(e.target.value)}/>
          <FaUser className="icon"/>
        </div>
        <div className='input-field'> 
          <input type="password" placeholder='Senha'
            required
            onChange={(e) => setPassword(e.target.value)}/>
          <FaLock className="icon"/>
        </div>
        <button type="submit">Cadastrar</button>   
      </form>
    </div>
  )
}

export default Cadastro