import sqlmodel
from sqlmodel import SQLModel
from .config import DATABASE_URL

if DATABASE_URL =="":
    raise NotImplementedError("DATABASE_URL need to be set")



engine = sqlmodel.create_engine(DATABASE_URL)

def init_db():
    print("Creating database tables...")
    SQLModel.metadata.create_all(engine)
    
    
def get_session():
    with Session(engine) as session:
        yield session
    

    