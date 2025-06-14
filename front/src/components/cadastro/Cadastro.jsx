import React, { useEffect, useState } from 'react'
import { useNavigate } from "react-router-dom";
import { FaUser, FaLock } from "react-icons/fa";
import "./Cadastro.css";
import { Link } from 'react-router-dom';
const Cadastro = () => {

  const navigate = useNavigate();
  const [nome, setName] = useState("");
  const [email, setUsername] = useState("");
  const [senha, setPassword] = useState("");

  const handleCadastro = async (event) => {
  event.preventDefault();
  const resp = await fetch("http://localhost:4000/api/users", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ user: { nome, email, senha } }),
  });
  if (resp.ok) {
    alert("Cadastro realizado!");
    navigate("/login");
  } else {
    const error = await resp.text();
    console.log("Erro do backend:", error);
    alert("Erro ao cadastrar!");
  }
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

        <div style={{ marginTop: "18px", textAlign: "center" }}>
          <span>Já tem conta? </span>
          <Link to="/login" style={{ color: "#fff", textDecoration: "underline", cursor: "pointer" }}>
            Clique Aqui.
          </Link>
        </div>
      </form>

    </div>
  )
}

export default Cadastro