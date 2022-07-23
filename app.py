import shutil
from tkinter import *
from tkinter.tix import ButtonBox

from click import command

janela = Tk()
janela.title("Exclusão de Pasta")

def exclusao():
    pasta = input("Qual pasta deseja excluir?")
    dirPath = pasta

    try:
        shutil.rmtree(dirPath)
    except OSError as e:
        print(f"Error:{ e.strerror}")

texto = Label(janela, text="Qual pasta deseja excluir?")
texto.grid(column=0, row=0)

txt = Entry(janela)
txt.grid(column=0, row=3)

botao = Button(janela, text="Excluir", command=exclusao)
botao.grid(column=0, row=4)

janela.mainloop()
