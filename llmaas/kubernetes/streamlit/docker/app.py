import streamlit as st
import requests
import json

st.set_page_config(page_title="Chat LLM - Streaming", page_icon="🤖")

st.title("🦙 Interface Universelle LLM (OpenAI/vLLM-compatible)")

def stream_openai_response(response):
    """
    Générateur pour extraire chaque morceau de texte du flux streaming OpenAI/vLLM.
    """
    for line in response.iter_lines():
        if line:
            s = line.decode("utf-8").strip()
            if s == "data: [DONE]":
                break
            if s.startswith("data: "):
                data = json.loads(s[6:])
                content = data["choices"][0]["delta"].get("content", "")
                if content:
                    yield content

# Initialiser l'historique des échanges
if "chat_history" not in st.session_state:
    st.session_state.chat_history = []

st.markdown("#### Paramètres du backend LLM")

with st.form("params"):
    endpoint = st.text_input("URL du endpoint OpenAI", value="http://llama-3-2-1b-instruct-predictor-00001.kserve-test.svc.cluster.local:80/v1/chat/completions")
    api_key = st.text_input("OpenAI API Key (ou clé dummy si aucun auth requis)", type="password")
    model = st.text_input("Nom du modèle", value="meta-llama/Llama-3.2-1B-Instruct")
    max_tokens = st.number_input("Nombre de tokens max.", min_value=1, value=512)
    temperature = st.slider("Température", min_value=0.0, max_value=2.0, value=1.0)
    stream_response = st.checkbox("Streamer la réponse", value=True)
    submitted = st.form_submit_button("Valider les paramètres")

st.divider()

user_input = st.chat_input("Votre prompt...")

if user_input:
    # Ajoute le prompt à l'historique
    st.session_state.chat_history.append({"role": "user", "content": user_input})

    # Headers et payload
    headers = {
        "Authorization": f"Bearer {api_key}" if api_key else "",
        "Content-Type": "application/json"
    }
    payload = {
        "model": model,
        "messages": [
            {"role": m["role"], "content": m["content"]}
            for m in st.session_state.chat_history
        ],
        "max_tokens": max_tokens,
        "temperature": temperature,
        "stream": stream_response
    }

    # Afficher le prompt utilisateur dans l’UI
    with st.chat_message("user"):
        st.markdown(user_input)

    # Affichage de la réponse du modèle
    with st.chat_message("assistant"):
        if not stream_response:
            response = requests.post(endpoint, headers=headers, json=payload)
            if response.ok:
                assistant_resp = response.json()["choices"][0]["message"]["content"]
                st.markdown(f"""
                    <div style="background-color:#f5f5f5;padding:15px 15px 15px 22px;border-radius:8px;max-width:80%;overflow-x:auto;">
                        {assistant_resp}
                    </div>
                """, unsafe_allow_html=True)
            else:
                st.error(response.text)
                assistant_resp = ""
        else:
            response_area = st.empty()
            assistant_resp = ""
            try:
                with requests.post(endpoint, headers=headers, json=payload, stream=True) as resp:
                    for content_piece in stream_openai_response(resp):
                        assistant_resp += content_piece
                        # Bulle style chat avec scroll auto si long
                        response_area.markdown(
                            f'<div style="background-color:#f5f5f5;padding:15px 15px 15px 22px;border-radius:8px;max-height:320px;overflow:auto;line-height:1.7;">{assistant_resp}</div>',
                            unsafe_allow_html=True
                        )
            except Exception as e:
                st.error(f"Erreur lors du streaming : {str(e)}")
                assistant_resp = ""
        # Ajoute la réponse du modèle à l'historique
        if assistant_resp:
            st.session_state.chat_history.append({"role": "assistant", "content": assistant_resp})

# Affichage rétroactif du fil de discussion
if st.session_state.chat_history:
    st.divider()
    st.markdown("### Historique du chat (session courante)")
    for m in st.session_state.chat_history:
        t = "user" if m["role"] == "user" else "assistant"
        icon = "🧑‍💻" if t == "user" else "🤖"
        st.markdown(f"**{icon} {t.capitalize()} :**")
        st.markdown(
            f"<div style='background-color:{'#cceafd' if t=='user' else '#f5f5f5'};padding:12px 12px 12px 16px;border-radius:7px;margin-bottom:8px;'>{m['content']}</div>",
            unsafe_allow_html=True
        )
