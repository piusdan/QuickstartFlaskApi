# Defines the basic schemas return by the API endpoints

from typing import TypeVar, Generic, Optional, Any

from pydantic import BaseModel, validator
from pydantic.generics import GenericModel

DataT = TypeVar('DataT')


class ApiError(BaseModel):
    code: int
    message: Any = None
    inner_error: Any = None


class ApiResponse(GenericModel, Generic[DataT]):
    data: Optional[DataT]
    error: Optional[ApiError]

    @validator('error', always=True)
    def check_consistency(cls, v, values):
        if v is not None and values['data'] is not None:
            raise ValueError('must not provide both data and error')
        if v is None and values.HttpGet('data') is None:
            raise ValueError('must provide data or error')
        return v
