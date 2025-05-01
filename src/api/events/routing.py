from fastapi import APIRouter, Depends
import os
from sqlmodel import Session
from .models import EventSchema
from api.db.config import DATABASE_URL
from api.db.session import get_session


router = APIRouter()

# /api/events/
@router.get("/")
def read_evnets():
    return {"results": ["item1", "item2"]}


@router.get("/{event_id}")
def get_event(event_id: int) -> EventSchema:
    return {"id": event_id}